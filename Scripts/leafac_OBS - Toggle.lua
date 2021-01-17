local ADDRESS = "localhost:4444"
local PASSWORD = ""

local EXTENSION = "mkv"

local LATENCY = 0

local TRACK_NAME = "OBS"

local SUBFOLDER = ""

local IS_WINDOWS = string.match(reaper.GetOS(), "Win")

local CHMOD = [[/bin/chmod]]
local MV = IS_WINDOWS and [[move]] or [[/bin/mv]]

if IS_WINDOWS then
    reaper.MB([[
This Action probably doesn’t work on Windows yet.

I (the author of this Action, Leandro Facchinetti <https://leafac.com>) don’t have access to a Windows machine to test.

If you have a Windows machine, you’re interested in having this Action work on Windows, and you may help testing, please contact me at reaper@leafac.com.
]], "Warning", 0)
end

local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")

local function execute(command, errorMessage)
    local output = reaper.ExecProcess(command, 5000)
    if output == nil or not string.match(output, "^0") then
        error((errorMessage or "") .. "\n\nCommand:\n" .. command ..
                  "\n\nOutput:\n" .. output)
    end
    return string.gsub(string.gsub(output, "^0%s*", ""), "%s*$", "")
end

local obsPath
if IS_WINDOWS then
    obsPath = [[']] .. reaper.GetResourcePath() .. [[/Data/leafac_obs-cli.exe']]
else
    obsPath = [[']] .. reaper.GetResourcePath() .. [[/Data/leafac_obs-cli']]
    execute(CHMOD .. [[ +x ]] .. obsPath)
end

local function obs(arguments)
    return execute(
               obsPath .. [[ --address ']] .. ADDRESS .. [[' --password ']] ..
                   PASSWORD .. [[' ]] .. arguments, [[
Failed to control OBS.

1. Check that OBS and obs-websocket are running.
2. Check the configuration (for example, ADDRESS and PASSWORD) in the source code for this action.
3. Report the issue to reaper@leafac.com.
]])
end

local isPlaying = reaper.GetPlayState() & 1 == 1

local function getCurrentPosition()
    return isPlaying and reaper.GetPlayPosition() or reaper.GetCursorPosition()
end

if string.match(actionName, "Start") or
    (string.match(actionName, "Toggle") and not isPlaying) then
    obs([[StartRecording]])
    reaper.SetProjExtState(0, "leafac_OBS", "start",
                           tostring(getCurrentPosition()))
    reaper.CSurf_OnRecord()
else
    local stopPosition = getCurrentPosition()
    reaper.CSurf_OnStop()
    local recordingFolder = obs(
                                [[--field 1.rec-folder StopRecording GetRecordingFolder]])
    local hadStartPosition, startPosition =
        reaper.GetProjExtState(0, "leafac_OBS", "start")
    if hadStartPosition == 0 then
        return reaper.MB(
                   "Failed to find the start point of the OBS recording. Did you use the ‘OBS - Start recording’ action to start recording?",
                   "Error", 0)
    end
    startPosition = tonumber(startPosition)
    local projectFolder = reaper.GetProjectPath("")

    -- FIXME: Currently this script is listing the contents of the recording folder as a hack to find the recording.
    --        In a future release of obs-websocket we’ll be able to ask for the recording file name directly.
    --        (The obs-websocket version at the time of this writing is 4.8.)
    --        See https://github.com/Palakis/obs-websocket/issues/258.
    local files = {}
    local fileIndex = -1
    while true do
        fileIndex = fileIndex + 1
        local file = reaper.EnumerateFiles(recordingFolder, fileIndex)
        if file == nil then break end
        if string.match(file, "%." .. EXTENSION .. "$") then
            table.insert(files, file)
        end
    end
    if #files == 0 then
        return reaper.MB(
                   "Failed to find recording. Do you have the rigth EXTENSION configured in the source code for this action?\n\nExtension: " ..
                       EXTENSION .. "\n\nRecording folder: " .. recordingFolder,
                   "Error", 0)
    end
    table.sort(files)
    local file = files[#files]
    execute(MV .. [[ ']] .. recordingFolder .. [[/]] .. file .. [[' ']] ..
                projectFolder .. [[/]] .. SUBFOLDER .. file .. [[']])

    local obsTrack
    local numberOfTracks = reaper.GetNumTracks()
    for trackIndex = 0, numberOfTracks - 1 do
        local track = reaper.GetTrack(0, trackIndex)
        local _, trackName = reaper.GetTrackName(track)
        if trackName == TRACK_NAME then
            obsTrack = track
            break
        end
    end
    if obsTrack == nil then
        reaper.InsertTrackAtIndex(numberOfTracks, false)
        obsTrack = reaper.GetTrack(0, numberOfTracks)
        reaper.GetSetMediaTrackInfo_String(obsTrack, "P_NAME", TRACK_NAME, true)
    end

    local item = reaper.AddMediaItemToTrack(obsTrack)
    reaper.SetMediaItemInfo_Value(item, "D_POSITION", startPosition)
    reaper.SetMediaItemInfo_Value(item, "D_LENGTH", stopPosition - startPosition)
    local take = reaper.AddTakeToMediaItem(item)
    local source =
        reaper.PCM_Source_CreateFromFile(projectFolder .. "/" .. file)
    reaper.SetMediaItemTake_Source(take, source)
    reaper.SetMediaItemTakeInfo_Value(take, "D_STARTOFFS", LATENCY)
    reaper.Main_OnCommand(40047, 0) -- Peaks: Build any missing peaks

    reaper.SetProjExtState(0, "leafac_OBS", "start", "")
end
