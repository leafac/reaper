reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40630, 0) -- Go to start of time selection
reaper.Main_OnCommand(1007, 0) -- Transport: Play

reaper.Undo_EndBlock(string.match(select(2, reaper.get_action_context()),
                                  "leafac_(.+)%.lua$"), -1)
