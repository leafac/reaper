-- https://youtu.be/O8o8z48rBbA
local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")
local shouldUndo =
    string.match(actionName, "Prepare selected items for editing") or
        string.match(actionName, "Truncate silence in selected items%.%.%.") or
        string.match(actionName,
                     "Truncate silence in selected items %(options%)%.%.%.")

local function run(description, identifier)
    local identifierNumber = type(identifier) == "number" and identifier or
                                 reaper.NamedCommandLookup(identifier, 0)
    if identifierNumber == 0 then
        error(
            "Command not found: “" .. description .. "” (" .. identifier ..
                "). For this script to work you must install SWS and all the packages from the default ReaPack repositories. If you already did that, then this is a bug; please report it to reaper@leafac.com or at https://github.com/leafac/reaper/issues/new.")
    end
    reaper.Main_OnCommand(identifierNumber, 0)
end

if reaper.CountSelectedMediaItems(0) == 0 then
    return reaper.MB("No items selected", "Error", 0)
end

if string.match(actionName, "Prepare selected items for editing") then
    run("SWS/BR: Normalize loudness of selected items to -23 LUFS",
        "_BR_NORMALIZE_LOUDNESS_ITEMS23")
end

reaper.Undo_BeginBlock()

if not string.match(actionName,
                    "Remove gaps between selected items %(Reposition selected items across tracks%)") then
    run("Item: Auto trim/split items (remove silence)...", 40315)
end

local items = {}
local minimumStart = math.huge
local maximumStop = -math.huge
for itemIndex = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0, itemIndex)
    local start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local stop = start + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    items[{start = start, stop = stop}] = true
    minimumStart = math.min(minimumStart, start)
    maximumStop = math.max(maximumStop, stop)
end

local gaps = {{start = minimumStart, stop = maximumStop}}
for item in pairs(items) do
    local newGaps = {}
    for _, gap in ipairs(gaps) do
        local candidateNewGaps = {
            {start = math.max(gap.start, item.stop), stop = gap.stop},
            {start = gap.start, stop = math.min(gap.stop, item.start)}
        }
        for _, candidateNewGap in ipairs(candidateNewGaps) do
            if candidateNewGap.start < candidateNewGap.stop then
                table.insert(newGaps, candidateNewGap)
            end
        end
    end
    gaps = newGaps
end

if shouldUndo then
    reaper.Undo_EndBlock(actionName .. " - WORK IN PROGRESS", -1)
    reaper.Undo_DoUndo2(0)
end

local userInputs = ""
if string.match(actionName, "%(options%)") then
    local continue
    continue, userInputs = reaper.GetUserInputs(actionName, 3,
                                                "Keep (%) (default: 0),Minimum (ms) (default: 0),Maximum (ms) (default: ∞)",
                                                "")
    if not continue then return end
end
local userInputsIterator = string.gmatch(userInputs, "[^,]*")
local keepPercentage = tonumber((userInputsIterator())) or 0
local keepMinimum = tonumber((userInputsIterator())) or 0
local keepMaximum = tonumber((userInputsIterator())) or math.huge

if shouldUndo then reaper.Undo_BeginBlock() end

for _, gap in ipairs(gaps) do
    local keepLength = math.max(keepMinimum / 1000, math.min(keepMaximum / 1000,
                                                             (gap.stop -
                                                                 gap.start) *
                                                                 keepPercentage /
                                                                 100))
    local start = gap.start + keepLength / 2
    local stop = gap.stop - keepLength / 2
    if start < stop then
        reaper.GetSet_LoopTimeRange(true, false, start, stop, false)
        run(
            "Time selection: Remove contents of time selection (moving later items)",
            40201)
    end
end

reaper.Undo_EndBlock(actionName, -1)
