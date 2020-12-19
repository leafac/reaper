local itemsCount = reaper.CountSelectedMediaItems(0)
if itemsCount == 0 then
    reaper.MB("No camera selection items selected", "Error", 0)
    return
end
local camera = string.match(select(2, reaper.get_action_context()),
                            "(%d+)%.lua$")
for itemIndex = 0, itemsCount - 1 do
    reaper.GetSetMediaItemTakeInfo_String(
        reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, itemIndex)),
        "P_NAME", camera, true)
end
