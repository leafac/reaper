local TRACK_NAME = "Multicam - Selector"

local cameraSwitches = {}
local markerIndex = 0
while true do
    local nextMakerIndex, _, position, _, name, _ =
        reaper.EnumProjectMarkers(markerIndex)
    local camera = string.match(name, "^Multicam %- Switch to camera (%d+)$")
    if camera ~= nil then
        table.insert(cameraSwitches, {
            camera = camera,
            position = position,
            markerIndex = markerIndex
        })
    end
    if nextMakerIndex == 0 then
        break
    else
        markerIndex = nextMakerIndex
    end
end
if #cameraSwitches == 0 then
    return reaper.MB("Camera switch makers not found", "Error", 0)
end

local selectorTrack
local numberOfTracks = reaper.GetNumTracks()
for trackIndex = 0, numberOfTracks - 1, 1 do
    local track = reaper.GetTrack(0, trackIndex)
    local _, trackName = reaper.GetTrackName(track)
    if string.match(trackName, string.gsub(TRACK_NAME, "%-", "%%-")) then
        selectorTrack = track
        break
    end
end
if selectorTrack == nil then
    if reaper.CountSelectedTracks(0) > 0 then
        selectorTrack = reaper.GetSelectedTrack(0, 0)
    else
        reaper.InsertTrackAtIndex(numberOfTracks, false)
        selectorTrack = reaper.GetTrack(0, numberOfTracks)
        reaper.GetSetMediaTrackInfo_String(selectorTrack, "P_NAME", TRACK_NAME,
                                           true)
    end
end

local currentPosition = reaper.GetProjectLength(0)
for cameraSwitchIndex = #cameraSwitches, 1, -1 do
    local cameraSwitch = cameraSwitches[cameraSwitchIndex]

    local item = reaper.AddMediaItemToTrack(selectorTrack)
    reaper.SetMediaItemInfo_Value(item, "D_POSITION", cameraSwitch.position)
    reaper.SetMediaItemInfo_Value(item, "D_LENGTH",
                                  currentPosition - cameraSwitch.position)
    local _, chunk = reaper.GetItemStateChunk(item, "", false)
    chunk = string.gsub(chunk, ">%s*$", [[
        NAME ]] .. cameraSwitch.camera .. "\n" .. [[
        <SOURCE VIDEOEFFECT
            <CODE
                | 
            >
        >
        %1
    ]])
    reaper.SetItemStateChunk(item, chunk, false)

    reaper.DeleteProjectMarkerByIndex(0, cameraSwitch.markerIndex)
    currentPosition = cameraSwitch.position
end
