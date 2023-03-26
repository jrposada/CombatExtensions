local CE = CombatExtensions

local Stats = ZO_Object:Subclass()

function Stats:New(...)
    local instance = ZO_Object.New(self)
    instance:Initialize(...)
    return instance
end

function Stats:Initialize(control)
    self.control = control
    self.phyisicalPen = control:GetNamedChild("PhysicalPen")
    self.weaponDamage = control:GetNamedChild("WeaponDamage")

    function OnShown()
        self.control:SetHidden(false)
    end

    function OnHidden()
        self.control:SetHidden(true)
    end

    EVENT_MANAGER:RegisterForEvent(CE.name .. "_Stats", EVENT_STATS_UPDATED, function() self:UpdateStats() end)
    EVENT_MANAGER:AddFilterForEvent(CE.name .. "_Stats", EVENT_STATS_UPDATED, REGISTER_FILTER_UNIT_TAG, "player")

    ZO_PreHookHandler(ZO_ActionBar1, 'OnEffectivelyShown', OnShown)
    ZO_PreHookHandler(ZO_ActionBar1, 'OnEffectivelyHidden', OnHidden)
end

function Stats:RestoreAnchor()
    local anchor = CE.SavedVars.modules.stats.anchor
    if anchor ~= nil then
        self.control:ClearAnchors()
        self.control:SetAnchor(anchor[1], GuiRoot, anchor[2], anchor[3], anchor[4])
    end
end

function Stats:UpdateStats()
    local phyisicalPen = tostring(GetPlayerStat(STAT_PHYSICAL_PENETRATION, STAT_BONUS_OPTION_APPLY_BONUS))
    local weaponDamage = tostring(GetPlayerStat(STAT_POWER, STAT_BONUS_OPTION_APPLY_BONUS))

    if phyisicalPen ~= self.phyisicalPen:GetText() then
        self.phyisicalPen:SetText((phyisicalPen))
    end

    if weaponDamage ~= self.weaponDamage:GetText() then
        self.weaponDamage:SetText((weaponDamage))
    end
end

function Stats:OnMoveStop()
    local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY, anchorConstrains = self.control:GetAnchor(0)
    CE.SavedVars.modules.stats.anchor = { point, relativePoint, offsetX, offsetY }
end

function CE_STATS_INITIALIZE_UI(control)
    CE_STATS = Stats:New(control)
end

function CE_STATS_ON_MOVE_STOP()
    CE_STATS:OnMoveStop()
end
