if reaper.CountSelectedTracks(0) == 0 then
    return reaper.MB("No tracks selected", "Error", 0)
end

local parentIndex = reaper.GetMediaTrackInfo_Value(
                        reaper.GetSelectedTrack(0, 0), "IP_TRACKNUMBER") - 1
reaper.InsertTrackAtIndex(parentIndex, true)
reaper.SetMediaTrackInfo_Value(reaper.GetTrack(0, parentIndex), "I_FOLDERDEPTH",
                               1, true)
local currentDepth = 0
for trackIndex = reaper.GetMediaTrackInfo_Value(
    reaper.GetSelectedTrack(0, reaper.CountSelectedTracks(0) - 1),
    "IP_TRACKNUMBER") - 1, reaper.CountTracks(0) - 1 do
    local track = reaper.GetTrack(0, trackIndex)
    local trackDepth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    currentDepth = currentDepth + trackDepth
    if currentDepth <= 0 then
        reaper.SetMediaTrackInfo_Value(track, "I_FOLDERDEPTH", trackDepth - 1,
                                       true)
        break
    end
end
