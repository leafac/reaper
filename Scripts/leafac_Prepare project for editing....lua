local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")
local isVideo = string.match(actionName, "video")

local continue, userInputs
if isVideo then
    continue, userInputs = reaper.GetUserInputs(actionName, 4,
                                                "Sample rate (default: 48000),Frame rate (default: 30),Video width (default: 1920),Video height (default: 1080)",
                                                "")
else
    continue, userInputs = reaper.GetUserInputs(actionName, 1,
                                                "Sample rate (default: 48000)",
                                                "")
end
if not continue then return end
local userInputsIterator = string.gmatch(userInputs, "[^,]*")
local sampleRate = tonumber(userInputsIterator()) or 48000
local frameRate = tonumber(userInputsIterator()) or 30
local videoWidth = tonumber(userInputsIterator()) or 1920
local videoHeight = tonumber(userInputsIterator()) or 1080

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

reaper.GetSetProjectInfo(0, "PROJECT_SRATE", sampleRate, true) -- Project Settings > Project Settings > Project sample rate > Number
reaper.GetSetProjectInfo(0, "PROJECT_SRATE_USE", 1, true) -- Project Settings > Project Settings > Project sample rate > Checkbox
if isVideo then
    reaper.SNM_SetIntConfigVar("projfrbase", frameRate) -- Project Settings > Video > Frame rate
    reaper.SNM_SetIntConfigVar("projvidw", videoWidth) -- Project Settings > Video > Preferred video size > Width
    reaper.SNM_SetIntConfigVar("projvidh", videoHeight) -- Project Settings > Video > Preferred video size > Height
end
run("View: Time unit for ruler: Hours:Minutes:Seconds:Frames", 40370)
run("View: Secondary time unit for ruler: None", 42360)
run(
    "Transport: Toggle preserve pitch in audio items when changing master playrate",
    40671, true)
run("Options: Toggle grid lines", 40145, false)
run([[SWS/BR: Options - Toggle "Grid snap settings follow grid visibility"]],
    "_BR_OPTIONS_SNAP_FOLLOW_GRID_VIS", not isVideo)
if isVideo then
    reaper.SNM_SetIntConfigVar("projgridframe", reaper.SNM_GetIntConfigVar(
                                   "projgridframe", 0) | 2) -- Grid/Snap Settings > Grid snap spacing: Frame
    reaper.SNM_SetIntConfigVar("projgridsnapmin", 0) -- Grid/Snap Settings > Grid snap spacing minimum
end

reaper.Undo_EndBlock(actionName, -1)
