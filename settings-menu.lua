local CE = CombatExtensions
local SettingsMenu = CE.SettingsMenu

function SettingsMenu.Initialize()
    local LAM = LibAddonMenu2

    local saveData = CE.SavedVars -- This should be a reference to your actual saved variables table
    local panelName = CE.name.."_SettingsPanel" -- The name will be used to create a global variable, pick something unique or you may overwrite an existing variable!

    local panelData = {
        type = "panel",
        name = "Combat Extensions",
        author = "Panicida",
        version = CE.version,
        registerForRefresh = true
    }
    local optionsData = {
        {
            type = "description",
            text = CE.Translate("settings.description")
        },
        {
            type = "divider"
        },
        {
            type = "submenu",
            name = CE.Translate("settings.debug"),
            controls = {
                {
                    type = "checkbox",
                    name = CE.Translate("settings.debug.enable"),
                    getFunc = function() return CE.CanDebug and saveData.debug.isEnabled end,
                    setFunc = function(value) saveData.debug.isEnabled = value end,
                }
            }
        },
    }

    LAM:RegisterAddonPanel(panelName, panelData)
    LAM:RegisterOptionControls(panelName, optionsData)
end
