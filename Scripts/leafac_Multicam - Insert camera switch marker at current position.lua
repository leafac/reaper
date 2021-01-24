reaper.AddProjectMarker(0, false,
                        reaper.GetPlayState() & 1 == 1 and
                            reaper.GetPlayPosition() or
                            reaper.GetCursorPosition(), 0,
                        "Multicam - Switch to camera " ..
                            string.match(select(2, reaper.get_action_context()),
                                         "leafac_.-(%d+).*%.lua$"), -1)
