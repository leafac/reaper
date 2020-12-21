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

reaper.Undo_EndBlock("Truncate silence in selected items... - WORK IN PROGRESS",
                     -1)
reaper.Undo_DoUndo2(0)

reaper.Undo_BeginBlock()

for _, gap in ipairs(gaps) do
    reaper.GetSet_LoopTimeRange(true, false, gap.start, gap.stop, false)
    reaper.Main_OnCommand(40201, 0) -- Time selection: Remove contents of time selection (moving later items)
end

reaper.Undo_EndBlock("Truncate silence in selected items...", -1)
