reaper.Undo_BeginBlock()
reaper.Main_OnCommand(40769, 0) -- Unselect (clear selection of) all tracks/items/envelope points
reaper.Main_OnCommand(40020, 0) -- Time selection: Remove (unselect) time selection and loop points
reaper.Undo_EndBlock("Unselect (clear selection of) all tracks, items, envelope points, time selection, and loop points", -1)
