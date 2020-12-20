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

run("SWS/BR: Normalize loudness of selected items to -23 LUFS",
    "_BR_NORMALIZE_LOUDNESS_ITEMS23")
run("Script: leafac_Truncate silence in selected items....lua",
    "_RS5a2c9bd3d4528369f57d919529e8eaf24610b33f")
run("SWS: Crossfade adjacent selected items (move edges of adjacent items)",
    "_SWS_CROSSFADE")
