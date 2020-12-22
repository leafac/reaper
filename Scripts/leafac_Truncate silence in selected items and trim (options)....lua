local actionName = string.match(select(2, reaper.get_action_context()),
                                "leafac_(.+)%.lua$")

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

run("Item: Auto trim/split items (remove silence)...", 40315)
if string.match(actionName, " %(options%)%.%.%.$") then
    run(
        "Script: leafac_Remove gaps between selected items (Reposition selected items across tracks) (options)....lua",
        "_RSadf42c7faac2d0b1d8736a6fcd7d2afb779e4418")
else
    run(
        "Script: leafac_Remove gaps between selected items (Reposition selected items across tracks).lua",
        "_RSc57125e96decf0607c2f1e2ab51965ed44d29f76")
end

reaper.Undo_EndBlock(actionName, -1)
