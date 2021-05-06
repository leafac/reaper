-- ffmpeg -i 2021-05-01\ 18-31-03.mkv -map 0:0 -c copy 2021-05-01\ 18-31-03--0.mp4 -map 0:1 2021-05-01\ 18-31-03--1.wav -map 0:2 2021-05-01\ 18-31-03--2.wav
-- FIXME: ffmpeg’s absolute path
local ffmpeg = "/usr/local/bin/ffmpeg"

local selectedMediaItemsCount = reaper.CountSelectedMediaItems(0)
if selectedMediaItemsCount == 0 then return end

local medias = {}
for selectedMediaItemIndex = 0, selectedMediaItemsCount - 1 do
    local mediaItem = reaper.GetSelectedMediaItem(0, selectedMediaItemIndex)
    local take = reaper.GetActiveTake(mediaItem)
    local source = reaper.GetMediaItemTake_Source(take)
    -- FIXME: Does Windows normalize ‘file’ to forward slashes?
    local file = reaper.GetMediaSourceFileName(source, "")
    table.insert(medias, {mediaItem = mediaItem, file = file, streams = {}})
end

local inspectCommandParts = {ffmpeg}
for _, media in ipairs(medias) do
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
    table.insert(medias[tonumber(input) + 1].streams, {isVideo = isVideo})
end

local convertCommandParts = {ffmpeg}
for inputIndex, media in ipairs(medias) do
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
        table.insert(convertCommandParts,
                     " -map " .. tostring(inputIndex - 1) .. ":" ..
                         tostring(streamIndex - 1) ..
                         (stream.isVideo and " -c copy" or "") .. " \"" .. file ..
                         "\"")
    end
end
local convertCommandResult = reaper.ExecProcess(table.concat(convertCommandParts), 0)
if convertCommandResult == nil or not string.match(convertCommandResult, "^0\n") then
  error("Convertion failed: " .. tostring(convertCommandResult))
end

-- reaper.ShowConsoleMsg(input .. "," .. stream .. "," .. description .. "\n")
-- reaper.ShowConsoleMsg(fileInformation .. "\n")

