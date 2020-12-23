if reaper.GetToggleCommandStateEx(0, 40671) ==
    (string.match(select(2, reaper.get_action_context()), "on%.lua$") and 0 or 1) then
    reaper.Main_OnCommand(40671, 0) -- Transport: Toggle preserve pitch in audio items when changing master playrate
end
