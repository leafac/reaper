if reaper.GetToggleCommandStateEx(0, 40145) ==
    (string.match(select(2, reaper.get_action_context()), "on%.lua$") and 0 or 1) then
    reaper.Main_OnCommand(40145, 0) -- Options: Toggle grid lines
end
