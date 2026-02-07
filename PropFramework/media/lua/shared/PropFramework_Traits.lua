
require "PropFramework_Core"

PropFramework.Traits = PropFramework.Traits or {}
PropFramework.Traits.Registry = {}

function PropFramework.Traits:Register(data)
    if not data or not data.name then
        error("[PropFramework] Trait registration failed: name is required")
        return false
    end
    
    if data.cost == nil then
        error("[PropFramework] Trait registration failed: cost is required")
        return false
    end
    
    local trait = {
        name = data.name,
        cost = data.cost,
        description = data.description or "",
        icon = data.icon or nil,
        mutuallyExclusive = data.mutuallyExclusive or {},
        requirements = data.requirements or {},
        effects = data.effects or {}
    }
    
    self.Registry[data.name] = trait
    
    PropFramework:DebugPrint("Registered trait: " .. data.name)
    return true
end

function PropFramework.Traits:Get(name)
    return self.Registry[name]
end

function PropFramework.Traits:GetAll()
    return self.Registry
end

function PropFramework.Traits:PlayerHas(player, traitName)
    return player:HasTrait(traitName)
end

function PropFramework.Traits:AddToPlayer(player, traitName)
    local trait = self:Get(traitName)
    if not trait then
        PropFramework:DebugPrint("Trait not found: " .. traitName)
        return false
    end
    
    for _, exclusiveTrait in ipairs(trait.mutuallyExclusive) do
        if self:PlayerHas(player, exclusiveTrait) then
            PropFramework:DebugPrint("Cannot add trait: mutually exclusive with " .. exclusiveTrait)
            return false
        end
    end
    
    player:getTraits():add(traitName)
    
    if trait.effects.onAdd then
        trait.effects.onAdd(player)
    end
    
    PropFramework:DebugPrint("Added trait " .. traitName .. " to player")
    return true
end

function PropFramework.Traits:RemoveFromPlayer(player, traitName)
    local trait = self:Get(traitName)
    if not trait then
        PropFramework:DebugPrint("Trait not found: " .. traitName)
        return false
    end
    
    player:getTraits():remove(traitName)
    
    if trait.effects and trait.effects.onRemove then
        trait.effects.onRemove(player)
    end
    
    PropFramework:DebugPrint("Removed trait " .. traitName .. " from player")
    return true
end

function PropFramework.Traits:CheckRequirements(player, traitName)
    local trait = self:Get(traitName)
    if not trait then
        return false
    end
    
    for _, requirement in ipairs(trait.requirements) do
        if requirement.type == "trait" then
            if not self:PlayerHas(player, requirement.value) then
                return false
            end
        elseif requirement.type == "skill" then
            local level = player:getPerkLevel(Perks[requirement.skill])
            if level < requirement.level then
                return false
            end
        end
    end
    
    return true
end

function PropFramework.Traits:SetMutuallyExclusive(traitName, exclusiveTraits)
    local trait = self:Get(traitName)
    if not trait then
        PropFramework:DebugPrint("Trait not found: " .. traitName)
        return false
    end
    
    trait.mutuallyExclusive = exclusiveTraits
    return true
end

function PropFramework.Traits:AddEffect(traitName, effectType, callback)
    local trait = self:Get(traitName)
    if not trait then
        PropFramework:DebugPrint("Trait not found: " .. traitName)
        return false
    end
    
    trait.effects[effectType] = callback
    return true
end

function PropFramework.Traits:Exists(name)
    return self.Registry[name] ~= nil
end

function PropFramework.Traits:Unregister(name)
    if self.Registry[name] then
        self.Registry[name] = nil
        PropFramework:DebugPrint("Unregistered trait: " .. name)
        return true
    end
    return false
end

PropFramework.Modules.Traits = true
