if reaper.CountSelectedMediaItems(0) == 0 then
    return reaper.MB("No items selected", "Error", 0)
end

local takesMarkers = {}

for itemIndex = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0, itemIndex)
    local take = reaper.GetActiveTake(item)
    local source = reaper.GetMediaItemTake_Source(take)
    local sourceFile = reaper.GetMediaSourceFileName(source, "")
    local csvFile = string.sub(sourceFile, 0, -1 - #".mkv") .. ".csv"
    if not reaper.file_exists(csvFile) then
        local shouldContinue, userCSVFile =
            reaper.GetUserFileNameForRead("", "OBS (InfoWriter) CSV", ".csv")
        if not shouldContinue then return end
        csvFile = userCSVFile
    end
    if not reaper.file_exists(csvFile) then
        return reaper.MB("CSV file not found: " .. csvFile, "Error", 0)
    end
    local csvFileHandler = assert(io.open(csvFile))
    local markers = {}
    for line in csvFileHandler:lines() do
        local hours, minutes, seconds, description =
            string.match(line, "(%d+):(%d+):(%d+),(.*)")
        if description == nil then
            return reaper.MB(
                       "Malformed CSV (was it produced by OBS (InfoWriter)?): " ..
                           csvFile, "Error", 0)
        end
        table.insert(markers, {
            position = tonumber(hours) * 60 * 60 + tonumber(minutes) * 60 +
                tonumber(seconds),
            description = description
        })
    end
    takesMarkers[take] = markers
    csvFileHandler:close()
end

for take, markers in pairs(takesMarkers) do
    for _, marker in pairs(markers) do
        reaper.SetTakeMarker(take, -1, marker.description, marker.position, 0)
    end
end
