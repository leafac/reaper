local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")

local function getAdvancedSetting(name, default)
    if reaper.HasExtState("leafac_OBS", name) then
        local value = reaper.GetExtState("leafac_OBS", name)
        if type(default) == "number" then
            return tonumber(value) or default
        elseif type(default) == "boolean" then
            return value ~= "false"
        else
            return value
        end
    else
        return default
    end
end

local ADVANCED_SETTINGS = {
    "ADDRESS", "PASSWORD", "EXTENSION", "LATENCY", "TRACK_NAME",
    "ALWAYS_CREATE_NEW_TRACK", "SUBFOLDER", "EXECUTE_TIMEOUT",
    "OBS_STOP_RECORDING_TIMEOUT"
}

local ADDRESS = getAdvancedSetting("ADDRESS", "localhost:4444")
local PASSWORD = getAdvancedSetting("PASSWORD", "")
local EXTENSION = getAdvancedSetting("EXTENSION", "mkv")
local LATENCY = getAdvancedSetting("LATENCY", 0)
local TRACK_NAME = getAdvancedSetting("TRACK_NAME", "OBS")
local ALWAYS_CREATE_NEW_TRACK = getAdvancedSetting("ALWAYS_CREATE_NEW_TRACK",
                                                   false)
local SUBFOLDER = getAdvancedSetting("SUBFOLDER", "")
local EXECUTE_TIMEOUT = getAdvancedSetting("EXECUTE_TIMEOUT", 5000)
local OBS_STOP_RECORDING_TIMEOUT = getAdvancedSetting(
                                       "OBS_STOP_RECORDING_TIMEOUT", 10)

if string.match(actionName, "Advanced settings") then
    local continue, userInputs = reaper.GetUserInputs(actionName,
                                                      #ADVANCED_SETTINGS,
                                                      "Address (" .. ADDRESS ..
                                                          ")," .. "Password (" ..
                                                          PASSWORD .. ")," ..
                                                          "Extension (" ..
                                                          EXTENSION .. ")," ..
                                                          "Latency (s) (" ..
                                                          LATENCY .. ")," ..
                                                          "Track name (" ..
                                                          TRACK_NAME .. ")," ..
                                                          "Always create new track (" ..
                                                          tostring(
                                                              ALWAYS_CREATE_NEW_TRACK) ..
                                                          ")," .. "Subfolder (" ..
                                                          SUBFOLDER .. ")," ..
                                                          "Execute timeout (ms) (" ..
                                                          EXECUTE_TIMEOUT ..
                                                          ")," ..
                                                          "OBS stop recording timeout (s) (" ..
                                                          OBS_STOP_RECORDING_TIMEOUT ..
                                                          ")", "")
    if not continue then return end
    local userInputsIterator = string.gmatch(userInputs, "[^,]*")
    for _, advancedSetting in ipairs(ADVANCED_SETTINGS) do
        local userInput = userInputsIterator()
        if userInput ~= nil and userInput ~= "" then
            reaper.SetExtState("leafac_OBS", advancedSetting, userInput, true)
        end
    end
    return
end

if string.match(actionName, "Reset advanced settings to factory defaults") then
    for _, advancedSetting in ipairs(ADVANCED_SETTINGS) do
        reaper.DeleteExtState("leafac_OBS", advancedSetting, true)
    end
    return
end

local isWindows = string.match(reaper.GetOS(), "Win")

local function execute(command, errorMessage)
    local output = reaper.ExecProcess(command, EXECUTE_TIMEOUT)
    if output == nil or not string.match(output, "^0") then
        error((errorMessage or "") .. "\n\nCommand:\n" .. command ..
                  "\n\nOutput:\n" .. tostring(output))
    end
    return string.gsub(string.gsub(output, "^0%s*", ""), "%s*$", "")
end

local obsCli = reaper.GetResourcePath() .. [[/Data/leafac_obs-cli]]
if isWindows then
    obsCli = obsCli .. [[.exe]]
else
    execute([[/bin/chmod +x "]] .. obsCli .. [["]])
end

local function obs(arguments)
    return execute([["]] .. obsCli .. [[" --address "]] .. ADDRESS ..
                       [[" --password "]] .. PASSWORD .. [[" ]] .. arguments, [[
Failed to control OBS.

1. Check that OBS and obs-websocket are running.
2. Check the configuration (for example, ADDRESS and PASSWORD) in the source code for this action.
3. Report the issue to reaper@leafac.com.
]])
end

local isPlaying = reaper.GetPlayState() & 1 == 1
local projectFolder = reaper.GetProjectPath("") .. SUBFOLDER

local function getCurrentPosition()
    return isPlaying and reaper.GetPlayPosition() or reaper.GetCursorPosition()
end

if string.match(actionName, "Start") or
    (string.match(actionName, "Toggle") and not isPlaying) then
    local originalRecordingFolder = obs(
                                        [[--field 0.rec-folder GetRecordingFolder ]] ..
                                            (isWindows and
                                                ([["SetRecordingFolder={ \"rec-folder\": \"]] ..
                                                    string.gsub(projectFolder,
                                                                [[\]], [[\\]]) ..
                                                    [[\" }"]]) or
                                                ([['SetRecordingFolder={ "rec-folder": "]] ..
                                                    projectFolder .. [[" }']])) ..
                                            [[ StartRecording]])
    local startPosition = getCurrentPosition()
    reaper.CSurf_OnRecord()

    reaper.SetProjExtState(0, "leafac_OBS", "startPosition",
                           tostring(startPosition))
    reaper.SetProjExtState(0, "leafac_OBS", "originalRecordingFolder",
                           originalRecordingFolder)
else
    local hadStartPosition, startPosition =
        reaper.GetProjExtState(0, "leafac_OBS", "startPosition")
    local hadOriginalRecordingFolder, originalRecordingFolder =
        reaper.GetProjExtState(0, "leafac_OBS", "originalRecordingFolder")
    if hadStartPosition == 0 or hadOriginalRecordingFolder == 0 then
        return reaper.MB(
                   "Failed to find an ongoing OBS recording. Did you start an OBS recording through REAPER?",
                   "Error", 0)
    end
    startPosition = tonumber(startPosition)

    local stopPosition = getCurrentPosition()
    reaper.CSurf_OnStop()
    obs([[StopRecording ]] ..
            (isWindows and ([["SetRecordingFolder={ \"rec-folder\": \"]] ..
                string.gsub(originalRecordingFolder, [[\]], [[\\]]) .. [[\" }"]]) or
                ([['SetRecordingFolder={ "rec-folder": "]] ..
                    originalRecordingFolder .. [[" }']])))
    local startWaitingObsStopRecording = reaper.time_precise()
    while obs([[--field 0.recording GetStreamingStatus]]) ~= "false" do
        if reaper.time_precise() > startWaitingObsStopRecording +
            OBS_STOP_RECORDING_TIMEOUT then
            return reaper.MB("Timed out waiting for OBS to stop recording",
                             "Error", 0)
        end
    end

    -- FIXME: Currently this script is listing the contents of the recording folder as a hack to find the recording.
    --        In a future release of obs-websocket we’ll be able to ask for the recording file name directly.
    --        (The obs-websocket version at the time of this writing is 4.8.)
    --        See https://github.com/Palakis/obs-websocket/issues/258.
    local files = {}
    for fileIndex = 0, math.huge do
        local file = reaper.EnumerateFiles(projectFolder, fileIndex)
        if file == nil then break end
        if string.match(file, "%." .. EXTENSION .. "$") then
            table.insert(files, file)
        end
    end
    if #files == 0 then
        return reaper.MB(
                   "Failed to find recording. Do you have the right EXTENSION configured in the source code for this action?\n\nExtension: " ..
                       EXTENSION .. "\n\nProject folder: " .. projectFolder,
                   "Error", 0)
    end
    table.sort(files)
    local file = files[#files]

    local obsTrack
    local numberOfTracks = reaper.GetNumTracks()
    for trackIndex = 0, numberOfTracks - 1, 1 do
        local track = reaper.GetTrack(0, trackIndex)
        local _, trackName = reaper.GetTrackName(track)
        if trackName == TRACK_NAME then
            obsTrack = track
            break
        end
    end
    if obsTrack == nil or ALWAYS_CREATE_NEW_TRACK then
        reaper.InsertTrackAtIndex(numberOfTracks, false)
        obsTrack = reaper.GetTrack(0, numberOfTracks)
        reaper.GetSetMediaTrackInfo_String(obsTrack, "P_NAME", TRACK_NAME, true)
    end

    local item = reaper.AddMediaItemToTrack(obsTrack)
    reaper.SetMediaItemInfo_Value(item, "D_POSITION", startPosition)
    reaper.SetMediaItemInfo_Value(item, "D_LENGTH", stopPosition - startPosition)
    local take = reaper.AddTakeToMediaItem(item)
    local source = reaper.PCM_Source_CreateFromFile(
                       projectFolder .. [[/]] .. file)
    reaper.SetMediaItemTake_Source(take, source)
    reaper.SetMediaItemTakeInfo_Value(take, "D_STARTOFFS", LATENCY)
    reaper.Main_OnCommand(40047, 0) -- Peaks: Build any missing peaks

    reaper.SetProjExtState(0, "leafac_OBS", "startPosition", "")
    reaper.SetProjExtState(0, "leafac_OBS", "originalRecordingFolder", "")
end
