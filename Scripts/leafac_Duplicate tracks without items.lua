reaper.Undo_BeginBlock()
reaper.Main_OnCommand(40062, 0) -- Track: Duplicate tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_DELALLITEMS"), 0) -- SWS: Delete all items on selected track(s)
reaper.Undo_EndBlock("Duplicate tracks without items", -1)

