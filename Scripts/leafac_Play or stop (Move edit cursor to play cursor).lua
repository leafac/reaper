reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40434, 0) -- View: Move edit cursor to play cursor
reaper.Main_OnCommand(40044, 0) -- Transport: Play/stop

reaper.Undo_EndBlock(string.match(select(2, reaper.get_action_context()),
                                  "leafac_(.+)%.lua$"), -1)
