if reaper.CountSelectedTracks(0) == 0 then
    return reaper.MB("No tracks selected", "Error", 0)
end

for selectedTrackIndex = reaper.CountSelectedTracks(0) - 1, 0, -1 do
    local selectedTrack = reaper.GetSelectedTrack(0, selectedTrackIndex)
    if reaper.GetMediaTrackInfo_Value(selectedTrack, "I_FOLDERDEPTH") == 1 then
        local currentDepth = 0
        for trackIndex = reaper.GetMediaTrackInfo_Value(selectedTrack,
                                                        "IP_TRACKNUMBER") - 1, reaper.CountTracks(
            0) - 1 do
            local track = reaper.GetTrack(0, trackIndex)
            local trackDepth = reaper.GetMediaTrackInfo_Value(track,
                                                              "I_FOLDERDEPTH")
            currentDepth = currentDepth + trackDepth
            if currentDepth <= 0 then
                reaper.SetMediaTrackInfo_Value(track, "I_FOLDERDEPTH",
                                               trackDepth + 1, true)
                break
            end
        end
        reaper.DeleteTrack(selectedTrack)
    end
end
