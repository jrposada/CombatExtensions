-- First, we create a namespace for our addon by declaring a top-level table that will hold everything else.
local CE = CombatExtensions
local EM = EVENT_MANAGER

local onAddOnLoadedEventName = '_OnAddOnLoaded'

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.
local function OnAddOnLoaded(eventCode, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName ~= CE.name then return end
    EM:UnregisterForEvent(CE.name .. onAddOnLoadedEventName, EVENT_ADD_ON_LOADED)

    -- Migrate old saved vars versions

    -- Load saved variables
    CE.SavedVars = ZO_SavedVars:NewAccountWide(CE.name .. "_Vars", CE.varsVersion, nil, CE.DefaultVars, GetWorldName())
    CE.CanDebug = GetDisplayName() == "@Panicida"

    -- Initialize stuff
    CE_CROWN.Initialize()
    CE_STATS:RestoreAnchor()

    -- Init settings menu
    CE.SettingsMenu.Initialize()
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(CE.name .. onAddOnLoadedEventName, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
