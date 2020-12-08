if reaper.Master_GetPlayRate(0) ~= 1 and reaper.MB(
    "The playrate isn’t 100%. Would you like to set it to 100% now to avoid issues in rendering?",
    "Error", 4) == 6 then reaper.CSurf_OnPlayRateChange(1) end
reaper.Main_OnCommand(40015, 0)
