local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")
local isVideo = string.match(actionName, "video")

local function run(description, identifier, isOn)
    local identifierNumber = type(identifier) == "number" and identifier or
                                 reaper.NamedCommandLookup(identifier, 0)
    if identifierNumber == 0 then
        error(
            "Command not found: “" .. description .. "” (" .. identifier ..
                "). For this script to work you must install SWS and all the packages from the default ReaPack repositories. If you already did that, then this is a bug; please report it to reaper@leafac.com or at https://github.com/leafac/reaper/issues/new.")
    end
    if isOn == nil or reaper.GetToggleCommandStateEx(0, identifierNumber) ==
        (isOn and 0 or 1) then reaper.Main_OnCommand(identifierNumber, 0) end
end

reaper.Undo_BeginBlock()

run("View: Time unit for ruler: Hours:Minutes:Seconds:Frames", 40370)
run("View: Secondary time unit for ruler: None", 42360)
run(
    "Transport: Toggle preserve pitch in audio items when changing master playrate",
    40671, true)
run("Options: Toggle grid lines", 40145, false)
reaper.MB(isVideo and [[
Set:
1. Project Settings > Project sample rate.
2. Video > Frame rate.
3. Video > Preferred video size.
]] or [[
Set Project Settings > Project sample rate.
]], "Project Settings", 0)
run("File: Project settings...", 40021)
if isVideo then
    run(
        [[SWS/BR: Options - Toggle "Grid snap settings follow grid visibility"]],
        "_BR_OPTIONS_SNAP_FOLLOW_GRID_VIS", false)
    reaper.MB([[
Set Grid snap spacing: Frame minimum 0 pixels.
]], "Grid/Snap Settings", 0)
    run("Options: Show snap/grid settings", 40071)
end

reaper.Undo_EndBlock(actionName, -1)
