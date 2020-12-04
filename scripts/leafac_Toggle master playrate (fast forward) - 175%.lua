reaper.CSurf_OnPlayRateChange(reaper.Master_GetPlayRate(0) == 1 and
                                  tonumber(
                                      string.match(
                                          select(2, reaper.get_action_context()),
                                          "leafac_Toggle master playrate %(fast forward%) %- (%d+)%%%.lua$")) /
                                  100 or 1)
