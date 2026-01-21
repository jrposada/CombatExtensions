-- =============================================================================
-- Crown Marker Module
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Localized Globals
-- -----------------------------------------------------------------------------
local EVENT_MANAGER = EVENT_MANAGER
local SetFloatingMarkerInfo = SetFloatingMarkerInfo
local EVENT_PLAYER_ACTIVATED = EVENT_PLAYER_ACTIVATED
local MAP_PIN_TYPE_GROUP_LEADER = MAP_PIN_TYPE_GROUP_LEADER

-- -----------------------------------------------------------------------------
-- Constants
-- -----------------------------------------------------------------------------
local CROWN_MARKER_SIZE = 64
local CROWN_MARKER_TEXTURE = "EsoUI/Art/Compass/groupleader.dds"

-- -----------------------------------------------------------------------------
-- Module Declaration
-- -----------------------------------------------------------------------------
local Crown = {}

-- -----------------------------------------------------------------------------
-- Private Functions
-- -----------------------------------------------------------------------------

--- Enables the crown marker for the group leader on the compass.
--- Sets the floating marker to display at the configured size and texture.
local function enableCrownMarker()
  SetFloatingMarkerInfo(
    MAP_PIN_TYPE_GROUP_LEADER,
    CROWN_MARKER_SIZE,
    CROWN_MARKER_TEXTURE
  )
end

-- -----------------------------------------------------------------------------
-- Public Functions
-- -----------------------------------------------------------------------------

--- Initializes the Crown module.
--- Registers for player activation to enable the crown marker.
function Crown.Initialize()
  local CE = CombatExtensions
  EVENT_MANAGER:RegisterForEvent(
    CE.name .. "_Crown_PlayerReady",
    EVENT_PLAYER_ACTIVATED,
    enableCrownMarker
  )
end

-- -----------------------------------------------------------------------------
-- Module Registration
-- -----------------------------------------------------------------------------
CombatExtensions.Crown = Crown
