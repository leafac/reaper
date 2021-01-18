local ADDRESS = "localhost:4444"
local PASSWORD = ""
local EXTENSION = "mkv"
local LATENCY = 0
local TRACK_NAME = "OBS"
local ALWAYS_CREATE_NEW_TRACK = false
local SUBFOLDER = ""
local EXECUTE_TIMEOUT = 5000
local OBS_RECORDING_STATUS_TIMEOUT = 10

local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")

local operatingSystem = reaper.GetOS()
if not (string.match(operatingSystem, "OSX") or
    string.match(operatingSystem, "mac")) then
    reaper.MB(
        "If you can help test this Action in other operating systems (Windows and Linux), please contact the author at reaper@leafac.com.",
        "This Action has been tested only in macOS.", 0)
end

local function execute(command, errorMessage)
    local output = reaper.ExecProcess(command, EXECUTE_TIMEOUT)
    if output == nil or not string.match(output, "^0") then
        error((errorMessage or "") .. "\n\nCommand:\n" .. command ..
                  "\n\nOutput:\n" .. output)
    end
    return string.gsub(string.gsub(output, "^0%s*", ""), "%s*$", "")
end

local obsCli = reaper.GetResourcePath() .. [[/Data/leafac_obs-cli]]
if string.match(operatingSystem, "Win") then
    obsCli = obsCli .. [[.exe]]
else
    execute([[/bin/chmod +x ']] .. obsCli .. [[']])
end

local function obs(arguments)
    return execute([[']] .. obsCli .. [[' --address ']] .. ADDRESS ..
                       [[' --password ']] .. PASSWORD .. [[' ]] .. arguments, [[
Failed to control OBS.

1. Check that OBS and obs-websocket are running.
2. Check the configuration (for example, ADDRESS and PASSWORD) in the source code for this action.
3. Report the issue to reaper@leafac.com.
]])
end

local function waitObsRecordingStatus(recordingStatus)
    local startTime = reaper.time_precise()
    while obs([[--field 0.recording GetStreamingStatus]]) ~=
        tostring(recordingStatus) do
        if reaper.time_precise() > startTime + OBS_RECORDING_STATUS_TIMEOUT then
            error("Timed out waiting for recording status to be " ..
                      recordingStatus .. ".")
        end
    end
end

local isPlaying = reaper.GetPlayState() & 1 == 1
local projectFolder = reaper.GetProjectPath("") .. [[/]] .. SUBFOLDER

local function getCurrentPosition()
    return isPlaying and reaper.GetPlayPosition() or reaper.GetCursorPosition()
end

local actionName = "TODO: Toggle"

if string.match(actionName, "Start") or
    (string.match(actionName, "Toggle") and not isPlaying) then
    local originalRecordingFolder = obs(
                                        [[--field 0.rec-folder GetRecordingFolder 'SetRecordingFolder={ "rec-folder": "]] ..
                                            projectFolder ..
                                            [[" }' StartRecording]])
    local startPosition = getCurrentPosition()
    reaper.CSurf_OnRecord()

    reaper.defer(function()
        waitObsRecordingStatus(true)

        reaper.SetProjExtState(0, "leafac_OBS", "startPosition",
                               tostring(startPosition))
        reaper.SetProjExtState(0, "leafac_OBS", "originalRecordingFolder",
                               originalRecordingFolder)

        local function latencyMeasurementsStep(latencyMeasurements)
            if #latencyMeasurements < 5 then
                -- reaper.defer(function()
                local before = reaper.GetPlayPosition()
                -- reaper.defer(function()
                local obsTimecodeString =
                    obs([[--field 0.rec-timecode GetStreamingStatus]])
                local obsTimecodeHours, obsTimecodeMinutes, obsTimecodeSeconds,
                      obsTimecodeMilliseconds =
                    string.match(obsTimecodeString, "^(%d+):(%d+):(%d+).(%d+)$")
                local obsTimecode = tonumber(obsTimecodeHours) * 60 * 60 +
                                        tonumber(obsTimecodeMinutes) * 60 +
                                        tonumber(obsTimecodeSeconds) +
                                        tonumber(obsTimecodeMilliseconds) / 1000
                -- reaper.defer(function()
                local after = reaper.GetPlayPosition()
                table.insert(latencyMeasurements, {
                    before = before,
                    obsTimecode = obsTimecode,
                    after = after
                })
                reaper.defer(function()
                    latencyMeasurementsStep(latencyMeasurements)
                end)
                -- end)
                -- end)
                -- end)
            else
                table.sort(latencyMeasurements,
                           function(latencyMeasurement1, latencyMeasurement2)
                    return latencyMeasurement1.obsTimecode -
                               (latencyMeasurement1.before - startPosition) <
                               latencyMeasurement2.obsTimecode -
                               (latencyMeasurement2.before - startPosition)
                end)
                local latency = 0
                -- for latencyMeasurementIndex = 3, #latencyMeasurements - 2 do
                local latencyMeasurement = latencyMeasurements[1]
                -- latencyMeasurements[latencyMeasurementIndex]
                latency =
                    latency + (latencyMeasurement.before - startPosition) -
                        latencyMeasurement.obsTimecode

                -- end
                -- latency = latency / (#latencyMeasurements - 4)

                reaper.ShowConsoleMsg("Before,OBS Timecode,After\n")
                for _, latencyMeasurement in ipairs(latencyMeasurements) do
                    reaper.ShowConsoleMsg(
                        (latencyMeasurement.before - startPosition) .. "," ..
                            latencyMeasurement.obsTimecode .. "," ..
                            (latencyMeasurement.after - startPosition) .. "\n")
                end
                reaper.ShowConsoleMsg("\nLatency," .. latency ..
                                          "\n\n--------------\n\n")

                reaper.SetProjExtState(0, "leafac_OBS", "latency", latency)
            end
        end
        latencyMeasurementsStep({})
    end)
else
    local hadStartPosition, startPosition =
        reaper.GetProjExtState(0, "leafac_OBS", "startPosition")
    local hadOriginalRecordingFolder, originalRecordingFolder =
        reaper.GetProjExtState(0, "leafac_OBS", "originalRecordingFolder")
    local hadLatency, latency = reaper.GetProjExtState(0, "leafac_OBS",
                                                       "latency")
    if hadStartPosition == 0 or hadOriginalRecordingFolder == 0 or hadLatency ==
        0 then
        return reaper.MB(
                   "Failed to find an ongoing OBS recording. Did you start an OBS recording through REAPER?",
                   "Error", 0)
    end
    startPosition = tonumber(startPosition)

    local stopPosition = getCurrentPosition()
    reaper.CSurf_OnStop()
    obs([[StopRecording 'SetRecordingFolder={ "rec-folder": "]] ..
            originalRecordingFolder .. [[" }']])
    waitObsRecordingStatus(false)

    -- FIXME: Currently this script is listing the contents of the recording folder as a hack to find the recording.
    --        In a future release of obs-websocket we’ll be able to ask for the recording file name directly.
    --        (The obs-websocket version at the time of this writing is 4.8.)
    --        See https://github.com/Palakis/obs-websocket/issues/258.
    local files = {}
    local fileIndex = -1
    while true do
        fileIndex = fileIndex + 1
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
    for trackIndex = 0, numberOfTracks - 1 do
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
    reaper.SetMediaItemTakeInfo_Value(take, "D_STARTOFFS", latency + LATENCY)
    reaper.Main_OnCommand(40047, 0) -- Peaks: Build any missing peaks

    reaper.SetProjExtState(0, "leafac_OBS", "startPosition", "")
    reaper.SetProjExtState(0, "leafac_OBS", "originalRecordingFolder", "")
    reaper.SetProjExtState(0, "leafac_OBS", "latency", "")
end
