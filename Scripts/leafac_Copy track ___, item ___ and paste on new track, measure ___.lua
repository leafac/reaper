local actionPath = select(2, reaper.get_action_context())
local actionDirname = string.match(actionPath, "^.+[/\\]")
local actionName = string.match(actionPath, "^.+[/\\]leafac_(.+)%.lua$")
local trackNumber, itemNumber, measureNumber =
    string.match(actionName,
                 "^Copy track (%d+), item (%d+) and paste on new track, measure (%d+)$")
trackNumber = tonumber(trackNumber)
itemNumber = tonumber(itemNumber)
measureNumber = tonumber(measureNumber)

if trackNumber == nil or itemNumber == nil or measureNumber == nil then
    local shouldContinue, userInputs = reaper.GetUserInputs("Create Action", 3,
                                                            "Track,Item,Measure",
                                                            "")
    if not shouldContinue then return end
    local userInputsIterator = string.gmatch(userInputs, "[^,]*")
    trackNumber = tonumber((userInputsIterator()))
    itemNumber = tonumber((userInputsIterator()))
    measureNumber = tonumber((userInputsIterator()))
    if trackNumber == nil or itemNumber == nil or measureNumber == nil then
        reaper.MB("Invalid inputs.", "Error", 0)
        return
    end
    local originalActionFile = assert(io.open(actionPath, "r"))
    local actionSource = originalActionFile:read("*a")
    originalActionFile:close()
    local copyActionPath =
        actionDirname .. "leafac_Copy track " .. trackNumber .. ", item " ..
            itemNumber .. " and paste on new track, measure " .. measureNumber ..
            ".lua"
    local copyActionFile = assert(io.open(copyActionPath, "w"))
    copyActionFile:write(actionSource)
    copyActionFile:close()
    reaper.AddRemoveReaScript(true, 0, copyActionPath, true)
    reaper.MB(copyActionPath, "Action Created at and Loaded into REAPER", 0)
    return
end

reaper.Undo_BeginBlock()
local track = reaper.GetTrack(0, trackNumber - 1)
if track == nil then
    reaper.MB("Track " .. tostring(trackNumber) .. " doesn’t exist.", "Error",
              0)
    return
end
local originalMediaItem = reaper.GetTrackMediaItem(track, itemNumber - 1)
if originalMediaItem == nil then
    reaper.MB("Track " .. tostring(trackNumber) .. ", item " ..
                  tostring(itemNumber) .. " doesn’t exist.", "Error", 0)
    return
end
local originalMediaItemChunkSuccess, originalMediaItemChunk =
    reaper.GetItemStateChunk(originalMediaItem, "", false)
if not originalMediaItemChunkSuccess then
    error("Failed to get chunck of ‘originalMediaItem’.")
end
local copyMediaItemChunk = string.gsub(originalMediaItemChunk, "{.-}", "")
reaper.InsertTrackAtIndex(reaper.GetNumTracks(), true)
local newTrack = reaper.GetTrack(0, reaper.GetNumTracks() - 1)
local copyMediaItem = reaper.AddMediaItemToTrack(newTrack)
reaper.SetItemStateChunk(copyMediaItem, copyMediaItemChunk)
reaper.SetMediaItemInfo_Value(copyMediaItem, "D_POSITION",
                              reaper.TimeMap_GetMeasureInfo(0, measureNumber - 1))
reaper.Main_OnCommand(40289, 0) -- Item: Unselect all items
reaper.SetMediaItemSelected(copyMediaItem, true)
reaper.Undo_EndBlock(actionName, -1)
