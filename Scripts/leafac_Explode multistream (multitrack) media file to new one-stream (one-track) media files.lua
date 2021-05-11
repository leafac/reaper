-- ffmpeg -i 2021-05-01\ 18-31-03.mkv -map 0:0 -c copy 2021-05-01\ 18-31-03--0.mp4 -map 0:1 2021-05-01\ 18-31-03--1.wav -map 0:2 2021-05-01\ 18-31-03--2.wav
-- FIXME: ffmpeg’s absolute path
local ffmpeg = "/usr/local/bin/ffmpeg"

local selectedMediaItemsCount = reaper.CountSelectedMediaItems(0)
if selectedMediaItemsCount == 0 then return end

local mediasToInspect = {}
for selectedMediaItemIndex = 0, selectedMediaItemsCount - 1 do
    local mediaItem = reaper.GetSelectedMediaItem(0, selectedMediaItemIndex)
    local take = reaper.GetActiveTake(mediaItem)
    local source = reaper.GetMediaItemTake_Source(take)
    -- FIXME: Does Windows normalize ‘file’ to forward slashes?
    local file = reaper.GetMediaSourceFileName(source, "")
    table.insert(mediasToInspect,
                 {mediaItem = mediaItem, file = file, streams = {}})
end

local inspectCommandParts = {ffmpeg}
for _, media in ipairs(mediasToInspect) do
    table.insert(inspectCommandParts, " -i \"" .. media.file .. "\"")
end
local fileInformation = reaper.ExecProcess(table.concat(inspectCommandParts),
                                           500)
if fileInformation == nil or not string.match(fileInformation, "1\n") then
    error("Error inspecting media file:\n\n" .. file .. "\n\n" ..
              tostring(fileInformation))
end
for input, stream, description in string.gmatch(fileInformation,
                                                "Stream #(%d+):(%d+)(.-)\n") do
    local isVideo = string.match(description, "Video:")
    table.insert(mediasToInspect[tonumber(input) + 1].streams,
                 {isVideo = isVideo})
end

local mediasToConvert = {}
for _, media in ipairs(mediasToInspect) do
    if #media.streams > 1 then table.insert(mediasToConvert, media) end
end
if #mediasToConvert == 0 then return end

local convertCommandParts = {ffmpeg}
for inputIndex, media in ipairs(mediasToConvert) do
    table.insert(convertCommandParts, " -i \"" .. media.file .. "\"")
    for streamIndex, stream in ipairs(media.streams) do
        local file
        local repeatedFileIndex = 1
        repeat
            file = string.match(media.file, "^(.*/.*)%..*$") .. " [stream " ..
                       tostring(streamIndex) .. "]" ..
                       (repeatedFileIndex == 1 and "" or
                           string.format(" %03d", repeatedFileIndex)) ..
                       (stream.isVideo and ".mp4" or ".wav")
            repeatedFileIndex = repeatedFileIndex + 1
        until not reaper.file_exists(file)
        stream.file = file
        table.insert(convertCommandParts,
                     " -map " .. tostring(inputIndex - 1) .. ":" ..
                         tostring(streamIndex - 1) ..
                         (stream.isVideo and " -c copy" or "") .. " \"" .. file ..
                         "\"")
    end
end
-- TODO: Create unique file names if multiple media items point at the same media file
local convertCommandResult = reaper.ExecProcess(table.concat(convertCommandParts), 0)
if convertCommandResult == nil or not string.match(convertCommandResult, "^0\n") then
  error("Convertion failed: " .. tostring(convertCommandResult))
end

local tracksToCreateMap = {}
for _, media in ipairs(mediasToConvert) do
    local track = reaper.GetMediaItemTrack(media.mediaItem)
    local trackNumber = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
    tracksToCreateMap[trackNumber] = math.max(
                                         tracksToCreateMap[trackNumber] or 0,
                                         #media.streams)
end

local tracksToCreateList = {}
for trackNumber, numberOfChildrenToCreate in ipairs(tracksToCreateMap) do
    table.insert(tracksToCreateList, {
        trackNumber = trackNumber,
        numberOfChildrenToCreate = numberOfChildrenToCreate
    })
end

table.sort(tracksToCreateList, function(trackToCreate1, trackToCreate2)
    return trackToCreate1.trackNumber > trackToCreate2.trackNumber
end)

for _, trackToCreate in ipairs(tracksToCreateList) do
    for _ = 1, trackToCreate.numberOfChildrenToCreate do
        reaper.InsertTrackAtIndex(trackToCreate.trackNumber, true)
    end
    local parentTrack = reaper.GetTrack(0, trackToCreate.trackNumber - 1)
    local _, parentTrackName = reaper.GetSetMediaTrackInfo_String(parentTrack,
                                                                  "P_NAME", "",
                                                                  false)
    for createdTrackIndex = 1, trackToCreate.numberOfChildrenToCreate do
        local createdTrack = reaper.GetTrack(0, trackToCreate.trackNumber +
                                                 createdTrackIndex - 1)
        reaper.GetSetMediaTrackInfo_String(createdTrack, "P_NAME",
                                           parentTrackName .. " [stream " ..
                                               tostring(createdTrackIndex) ..
                                               "]", true)
    end
    local parentTrackDepth = reaper.GetMediaTrackInfo_Value(parentTrack,
                                                            "I_FOLDERDEPTH")
    reaper.SetMediaTrackInfo_Value(parentTrack, "I_FOLDERDEPTH", 1)
    local lastChildTrack = reaper.GetTrack(0, trackToCreate.trackNumber +
                                               trackToCreate.numberOfChildrenToCreate -
                                               1)
    reaper.SetMediaTrackInfo_Value(lastChildTrack, "I_FOLDERDEPTH",
                                   parentTrackDepth - 1)
    -- FIXME: This doesn’t work when the track is a child track.
end

-- FIXME: Is there a way to just copy the existing item and change the source underneath, instead
-- of creating new items and copying properties by hand?
for _, media in ipairs(mediasToConvert) do
    local track = reaper.GetMediaItemTrack(media.mediaItem)
    local trackNumber = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
    local position = reaper.GetMediaItemInfo_Value(media.mediaItem, "D_POSITION")
    local length = reaper.GetMediaItemInfo_Value(media.mediaItem, "D_LENGTH")
    local mute = reaper.GetMediaItemInfo_Value(media.mediaItem, "B_MUTE")
    reaper.SetMediaItemInfo_Value(media.mediaItem, "B_MUTE", 1)
    local take = reaper.GetActiveTake(media.mediaItem)
    local startOffset = reaper.GetMediaItemTakeInfo_Value(take, "D_STARTOFFS")
    for streamIndex, stream in ipairs(media.streams) do
        local streamTrack = reaper.GetTrack(0, trackNumber + streamIndex - 1)
        local streamMediaItem = reaper.AddMediaItemToTrack(streamTrack)
        reaper.SetMediaItemInfo_Value(streamMediaItem, "D_POSITION", position)
        reaper.SetMediaItemInfo_Value(streamMediaItem, "D_LENGTH", length)
        reaper.SetMediaItemInfo_Value(streamMediaItem, "B_MUTE", mute)
        local streamTake = reaper.AddTakeToMediaItem(streamMediaItem)
        reaper.SetMediaItemTakeInfo_Value(streamTake, "D_STARTOFFS", startOffset)
        local source = reaper.PCM_Source_CreateFromFile(stream.file)
        reaper.SetMediaItemTake_Source(streamTake, source)
    end
end
reaper.Main_OnCommand(40047, 0) -- Peaks: Build any missing peaks

