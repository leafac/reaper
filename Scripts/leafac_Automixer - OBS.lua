local group = 1
local video_track_to_obs_scene = {[1] = "SPEAKER 1", [2] = "SPEAKER 2"}

------------------------------------------------------------------------------

local scene = nil
local previous_scene = nil

reaper.gmem_attach("leafac_automixer")

local function loop()
    scene = video_track_to_obs_scene[reaper.gmem_read(group) + 1]
    if scene ~= previous_scene then reaper.ShowConsoleMsg(scene .. "\n") end
    previous_scene = scene
    reaper.defer(loop)
end

reaper.defer(loop)
