local items = reaper.CountSelectedMediaItems(0)
if items == 0 then
    reaper.MB("No camera selection items selected.", "Error", 0)
    return
end
reaper.Main_OnCommand(40012, 0) -- Item: Split items at edit or play cursor
local camera = string.match(select(2, reaper.get_action_context()),
                            "(%d+)%.lua$")
for index = 0, reaper.CountSelectedMediaItems(0) - 1 do
    reaper.GetSetMediaItemTakeInfo_String(
        reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, index)), "P_NAME",
        camera, true)
end
