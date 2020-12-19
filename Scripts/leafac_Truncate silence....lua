if reaper.CountSelectedMediaItems(0) == 0 then
    return reaper.MB("No items selected", "Error", 0)
end

local function run(description, identifier)
    local identifierNumber = type(identifier) == "number" and identifier or
                                 reaper.NamedCommandLookup(identifier, 0)
    if identifierNumber == 0 then
        error(
            "Command not found: “" .. description .. "” (" .. identifier ..
                "). For this script to work you should install SWS and all the packages from the default ReaPack repositories. If you already did that, then this is a bug; please report it to reaper@leafac.com or at https://github.com/leafac/reaper/issues/new.")
    end
    reaper.Main_OnCommand(identifierNumber, 0)
end

reaper.Undo_BeginBlock()

run("SWS/BR: Normalize loudness of selected items to -23 LUFS",
    "_BR_NORMALIZE_LOUDNESS_ITEMS23")
run("Item: Auto trim/split items (remove silence)...", 40315)
run(
    "Script: leafac_Remove gaps between selected items (Reposition selected items across tracks).lua",
    "_RS0b464a9bf9f8e3f93acce0c86693904bf0011bda")
run("SWS: Crossfade adjacent selected items (move edges of adjacent items)",
    "_SWS_CROSSFADE")

reaper.Undo_EndBlock("leafac_Truncate silence...", -1)
