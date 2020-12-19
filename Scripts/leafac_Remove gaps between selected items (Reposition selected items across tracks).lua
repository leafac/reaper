local itemsCount = reaper.CountSelectedMediaItems(0)
if itemsCount == 0 then return reaper.MB("No items selected", "Error", 0) end

local items = {}
local minimumStart = math.huge
local maximumStop = -math.huge
for itemIndex = 0, itemsCount - 1 do
    local item = reaper.GetSelectedMediaItem(0, itemIndex)
    local start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local stop = start + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    table.insert(items, {start = start, stop = stop})
    minimumStart = math.min(minimumStart, start)
    maximumStop = math.max(maximumStop, stop)
end

local gaps = {{start = minimumStart, stop = maximumStop}}
for _, item in ipairs(items) do
    local newGaps = {}
    local function addGap(gap)
        if gap.start < gap.stop then table.insert(newGaps, gap) end
    end
    for _, gap in ipairs(gaps) do
        addGap({start = gap.start, stop = math.min(gap.stop, item.start)})
        addGap({start = math.max(gap.start, item.stop), stop = gap.stop})
    end
    gaps = newGaps
end

reaper.Undo_BeginBlock()

for index = #gaps, 1, -1 do
    local gap = gaps[index]
    reaper.GetSet_LoopTimeRange(true, false, gap.start, gap.stop, false)
    reaper.Main_OnCommand(40201, 0) -- Time selection: Remove contents of time selection (moving later items)
end

reaper.Undo_EndBlock(
    "leafac_Remove gaps between selected items (Reposition selected items across tracks)",
    -1)
