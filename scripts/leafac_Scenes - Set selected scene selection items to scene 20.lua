local scene = string.match(select(2, reaper.get_action_context()),
                           "leafac_Scenes %- Set selected scene selection items to scene (%d+)%.lua$")
for index = 0, reaper.CountSelectedMediaItems(0) - 1 do
    reaper.GetSetMediaItemTakeInfo_String(
        reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, index)), "P_NAME",
        scene, true)
end
