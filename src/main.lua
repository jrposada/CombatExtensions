-- =============================================================================
-- Localized Globals
-- =============================================================================
local EVENT_MANAGER = EVENT_MANAGER
local EVENT_ADD_ON_LOADED = EVENT_ADD_ON_LOADED
local ZO_SavedVars = ZO_SavedVars
local GetWorldName = GetWorldName
local GetDisplayName = GetDisplayName

-- =============================================================================
-- Constants
-- =============================================================================
local ON_ADDON_LOADED_EVENT_NAME = "_OnAddOnLoaded"

-- =============================================================================
-- Module Declaration
-- =============================================================================
local CE = CombatExtensions

-- =============================================================================
-- Private Functions
-- =============================================================================

--- Event handler for addon loaded event.
--- Initializes the addon when it is fully loaded.
--- @param eventCode number The event code
--- @param addonName string The name of the addon that was loaded
local function onAddOnLoaded(eventCode, addonName)
    -- Only initialize when our addon loads
    if addonName ~= CE.name then return end
    EVENT_MANAGER:UnregisterForEvent(CE.name .. ON_ADDON_LOADED_EVENT_NAME, EVENT_ADD_ON_LOADED)

    -- Load saved variables
    CE.SavedVars = ZO_SavedVars:NewAccountWide(CE.name .. "_Vars", CE.varsVersion, nil, CE.DefaultVars, GetWorldName())
    CE.CanDebug = GetDisplayName() == "@Panicida"

    -- Initialize modules
    CE_CROWN.Initialize()
    CE_STATS:RestoreAnchor()

    -- Initialize settings menu
    CE.SettingsMenu.Initialize()
end

-- =============================================================================
-- Initialization
-- =============================================================================
EVENT_MANAGER:RegisterForEvent(CE.name .. ON_ADDON_LOADED_EVENT_NAME, EVENT_ADD_ON_LOADED, onAddOnLoaded)
