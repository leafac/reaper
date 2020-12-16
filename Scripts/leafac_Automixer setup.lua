local tracks = {}
for trackIndex = 0, reaper.CountSelectedTracks(0) - 1 do
    table.insert(tracks, reaper.GetSelectedTrack(0, trackIndex))
end
if #tracks == 0 then return reaper.MB("No tracks selected.", "Error", 0) end

local channelsPerTrack = 0
for _, track in ipairs(tracks) do
    channelsPerTrack = math.max(channelsPerTrack,
                                reaper.GetMediaTrackInfo_Value(track, "I_NCHAN"))
end

local parentChannels = #tracks * channelsPerTrack
if parentChannels > 64 then
    return reaper.MB(
               "The Automixer track would need to have " .. parentChannels ..
                   " channels, which is more than the 64 supported by REAPER.",
               "Error", 0)
end

local parentIndex =
    reaper.GetMediaTrackInfo_Value(tracks[1], "IP_TRACKNUMBER") - 1
reaper.InsertTrackAtIndex(parentIndex, true)
local parent = reaper.GetTrack(0, parentIndex)
reaper.SetMediaTrackInfo_Value(parent, "I_FOLDERDEPTH", 1, true)
reaper.SetMediaTrackInfo_Value(tracks[#tracks], "I_FOLDERDEPTH",
                               reaper.GetMediaTrackInfo_Value(tracks[#tracks],
                                                              "I_FOLDERDEPTH") -
                                   1, true)
reaper.SetMediaTrackInfo_Value(parent, "I_NCHAN", parentChannels)
for index, track in ipairs(tracks) do
    reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", channelsPerTrack)
    reaper.SetMediaTrackInfo_Value(track, "C_MAINSEND_OFFS",
                                   (index - 1) * channelsPerTrack)
end
local automixerFX = reaper.TrackFX_AddByName(parent, "leafac_Automixer.jsfx",
                                             false, -1)
reaper.TrackFX_Show(parent, automixerFX, 3)
