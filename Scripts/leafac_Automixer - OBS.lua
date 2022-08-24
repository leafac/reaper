local group = 1
local video_track_to_obs_scene = {[1] = "SPEAKER 1", [2] = "SPEAKER 2"}

------------------------------------------------------------------------------

reaper.gmem_attach("leafac_automixer")

local function loop()
    reaper.ShowConsoleMsg(
        video_track_to_obs_scene[reaper.gmem_read(group) + 1] .. "\n")
    reaper.defer(loop)
end

reaper.defer(loop)
