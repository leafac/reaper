reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40057, 0) -- Edit: Copy items/tracks/envelope points (depending on focus) ignoring time selection
reaper.Main_OnCommand(42398, 0) -- Item: Paste items/tracks

reaper.Undo_EndBlock(string.match(select(2, reaper.get_action_context()),
                                  "leafac_(.+)%.lua$"), -1)
