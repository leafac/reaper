-- https://youtu.be/mQUaPRs0KIU
local playrate = tonumber(string.match(select(2, reaper.get_action_context()),
                                       "(%d+)%%%.lua$")) / 100
reaper.CSurf_OnPlayRateChange(reaper.Master_GetPlayRate(0) == playrate and 1 or
                                  playrate)
