local CE = CombatExtensions

GroupControl = ZO_Object:Subclass()

function GroupControl:New(...)
    local instance = ZO_Object.New(self)
    instance:Initialize(...)
    return instance
end

function GroupControl:Initialize(control)
    self.control = control
    self.isDirty = true

    local function MarkDirty()
        self.isDirty = true
    end

    local function OnUpdate()
        if self.isDirty then
            self:Update()
        end
        -- self:RefreshContainerVisibility()
        -- self:UpdateTime()
    end

    control:RegisterForEvent(EVENT_EFFECTS_FULL_UPDATE, MarkDirty)
    control:RegisterForEvent(EVENT_EFFECT_CHANGED, MarkDirty)
    control:AddFilterForEvent(EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "player")
    control:RegisterForEvent(EVENT_ARTIFICIAL_EFFECT_ADDED, MarkDirty)
    control:RegisterForEvent(EVENT_ARTIFICIAL_EFFECT_REMOVED, MarkDirty)
    control:SetHandler("OnUpdate", OnUpdate)
end

function GroupControl:Update()
    for effectId in ZO_GetNextActiveArtificialEffectIdIter do
        local displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding = GetArtificialEffectInfo(
            effectId)
        local duration = timeEnding - timeStarted
        local permanent = duration == 0

        local data =
        {
            buffName = displayName,
            timeStarted = timeStarted,
            timeEnding = timeEnding,
            iconFilename = iconFile,
            stackCount = 0,
            effectType = effectType,
            duration = duration,
            permanent = permanent,
            sortOrder = sortOrder,
            effectId = effectId,
            isArtificial = true,
        }
        CE.LogLater(data)

        -- local appropriateTable = (data.effectType == BUFF_EFFECT_TYPE_BUFF) and self.sortedBuffs or self.sortedDebuffs
        -- table.insert(appropriateTable, data)
        -- uid = uid + 1
    end

    for i = 1, GetNumBuffs("player") do
        local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, _, castByPlayer =
            GetUnitBuffInfo("player", i)
        local duration = timeEnding - timeStarted
        local permanent = duration == 0

        local data =
        {
            buffName = buffName,
            timeStarted = timeStarted,
            timeEnding = timeEnding,
            buffSlot = buffSlot,
            stackCount = stackCount,
            iconFilename = iconFilename,
            buffType = buffType,
            effectType = effectType,
            abilityType = abilityType,
            statusEffectType = statusEffectType,
            abilityId = abilityId,
            duration = duration,
            castByPlayer = castByPlayer,
            permanent = permanent,
            isArtificial = false,
        }
        CE.LogLater(data)
    end

    self.isDirty = false
end

function CE_GROUP_CONTROL_INITIALIZE_UI(control)
    CE_GROUP_CONTROL = GroupControl:New(control)
end
