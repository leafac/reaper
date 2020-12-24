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

reaper.Undo_BeginBlock()

run("SWS: Set time selection to selected items (skip if time selection exists)",
    "_SWS_SAFETIMESEL")
run("Time selection: Remove contents of time selection (moving later items)",
    40201)

reaper.Undo_EndBlock(string.match(select(2, reaper.get_action_context()),
                                  "leafac_(.+)%.lua$"), -1)
