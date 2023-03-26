local CE = CombatExtensions

CE_CROWN = {}

function CE_CROWN.Initialize()
    local function EnableCrownMarker()
        SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, 64, "EsoUI/Art/Compass/groupleader.dds")
    end

    EVENT_MANAGER:RegisterForEvent(CE.name .. "_Crown_PlayerReady", EVENT_PLAYER_ACTIVATED, EnableCrownMarker)
end
