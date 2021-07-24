local actionPath = select(2, reaper.get_action_context())
local actionDirname = string.match(actionPath, "^.+[/\\]")
local actionName = string.match(actionPath, "^.+[/\\]leafac_(.+)%.lua$")
local from, to, times = string.match(actionName,
                                     "^Play from ([%d%.]+) to ([%d%.]+) in loop for (%d+) times and then unloop$")
times = tonumber(times)

if from == nil or to == nil or times == nil then
    local shouldContinue, userInputs = reaper.GetUserInputs("Create Action", 3,
                                                            "From (for example, 3.1.00),To (for example, 7.2.00),Times",
                                                            "")
    if not shouldContinue then return end
    local userInputsIterator = string.gmatch(userInputs, "[^,]*")
    from = string.match(userInputsIterator(), "^[%d%.]+$")
    to = string.match(userInputsIterator(), "^[%d%.]+$")
    times = tonumber((userInputsIterator()))
    if from == nil or to == nil or times == nil then
        reaper.MB("Invalid inputs.", "Error", 0)
        return
    end
    if reaper.parse_timestr_pos(from, 2) >= reaper.parse_timestr_pos(to, 2) then
        reaper.MB("‘From’ position isn’t before ‘to’ position",
                  "Error", 0)
        return
    end
    if times <= 0 then
        reaper.MB("‘Times’ is non-positive", "Error", 0)
        return
    end
    local originalActionFile = assert(io.open(actionPath, "r"))
    local actionSource = originalActionFile:read("*a")
    originalActionFile:close()
    local copyActionPath = actionDirname .. "leafac_Play from " .. from ..
                               " to " .. to .. " in loop for " .. times ..
                               " times and then unloop.lua"
    local copyActionFile = assert(io.open(copyActionPath, "w"))
    copyActionFile:write(actionSource)
    copyActionFile:close()
    reaper.AddRemoveReaScript(true, 0, copyActionPath, true)
    reaper.MB(copyActionPath, "Action Created at and Loaded into REAPER", 0)
    return
end

local loopStart = reaper.parse_timestr_pos(from, 2)
local loopEnd = reaper.parse_timestr_pos(to, 2)

reaper.GetSetRepeat(1)
reaper.GetSet_LoopTimeRange(true, true, loopStart, loopEnd, false)
reaper.SetEditCurPos(loopStart, false, false)
reaper.OnPlayButton()

local previousPlayPosition = reaper.GetPlayPosition()
local currentLoop = 1
local function defer()
    if reaper.GetPlayPosition() < previousPlayPosition then
        currentLoop = currentLoop + 1
    end
    if currentLoop == times then
        reaper.GetSetRepeat(0)
        reaper.Main_OnCommand(40020, 0) -- Time selection: Remove time selection and loop points
        return
    end
    previousPlayPosition = reaper.GetPlayPosition()
    reaper.defer(defer)
end
reaper.defer(defer)
