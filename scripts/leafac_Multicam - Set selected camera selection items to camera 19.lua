local camera = string.match(select(2, reaper.get_action_context()),
                            "(%d+)%.lua$")
for index = 0, reaper.CountSelectedMediaItems(0) - 1 do
    reaper.GetSetMediaItemTakeInfo_String(
        reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, index)), "P_NAME",
        camera, true)
end
