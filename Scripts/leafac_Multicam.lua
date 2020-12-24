-- https://youtu.be/1BvuRgKNnqc
local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")
local isSplit = string.match(actionName, "Split")
local camera = string.match(actionName, "(%d+)$")

local itemsCount = reaper.CountSelectedMediaItems(0)
if itemsCount == 0 then
    reaper.MB("No camera selection items selected", "Error", 0)
    return
end

if isSplit then
    reaper.Main_OnCommand(40012, 0) -- Item: Split items at edit or play cursor
end

for itemIndex = 0, itemsCount - 1 do
    reaper.GetSetMediaItemTakeInfo_String(
        reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, itemIndex)),
        "P_NAME", camera, true)
end
