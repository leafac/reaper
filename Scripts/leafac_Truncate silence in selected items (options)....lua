local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")

if reaper.CountSelectedMediaItems(0) == 0 then
    return reaper.MB("No items selected", "Error", 0)
end

reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40315, 0) -- Item: Auto trim/split items (remove silence)...

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

reaper.Undo_EndBlock(actionName .. " - WORK IN PROGRESS", -1)
reaper.Undo_DoUndo2(0)

local userInputs = ""
if string.match(actionName, "%(options%)%.%.%.$") then
    local continue
    continue, userInputs = reaper.GetUserInputs(actionName, 3,
                                                "Keep (%) (default: 0),Minimum (ms) (default: 0),Maximum (ms) (default: ∞)",
                                                "")
    if not continue then return end
end
local userInputsIterator = string.gmatch(userInputs, "[^,]*")
local keepPercentage = tonumber(userInputsIterator() or nil) or 0
local keepMinimum = tonumber(userInputsIterator() or nil) or 0
local keepMaximum = tonumber(userInputsIterator() or nil) or math.huge

reaper.Undo_BeginBlock()

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
        reaper.Main_OnCommand(40201, 0) -- Time selection: Remove contents of time selection (moving later items)
    end
end

reaper.Undo_EndBlock(actionName, -1)
