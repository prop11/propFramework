
require "PropFramework_Core"

PropFramework.Professions = PropFramework.Professions or {}
PropFramework.Professions.Registry = {}

function PropFramework.Professions:Register(data)
    if not data or not data.name then
        error("[PropFramework] Profession registration failed: name is required")
        return false
    end
    
    if not data.type then
        data.type = "profession"
    end
    
    local profession = {
        name = data.name,
        type = data.type,
        cost = data.cost or 0,
        xp = data.xp or {},
        traits = data.traits or {},
        recipes = data.recipes or {},
        description = data.description or "",
        icon = data.icon or nil,
        items = data.items or {}
    }
    
    self.Registry[data.name] = profession
    
    PropFramework:DebugPrint("Registered profession: " .. data.name)
    return true
end

function PropFramework.Professions:Get(name)
    return self.Registry[name]
end

function PropFramework.Professions:GetAll()
    return self.Registry
end

function PropFramework.Professions:AddSkillXP(professionName, perk, xpAmount)
    local profession = self:Get(professionName)
    if not profession then
        PropFramework:DebugPrint("Profession not found: " .. professionName)
        return false
    end
    
    profession.xp[perk] = (profession.xp[perk] or 0) + xpAmount
    return true
end

function PropFramework.Professions:AddTrait(professionName, trait)
    local profession = self:Get(professionName)
    if not profession then
        PropFramework:DebugPrint("Profession not found: " .. professionName)
        return false
    end
    
    table.insert(profession.traits, trait)
    return true
end

function PropFramework.Professions:AddRecipe(professionName, recipe)
    local profession = self:Get(professionName)
    if not profession then
        PropFramework:DebugPrint("Profession not found: " .. professionName)
        return false
    end
    
    table.insert(profession.recipes, recipe)
    return true
end

function PropFramework.Professions:AddStartingItem(professionName, itemType, count)
    local profession = self:Get(professionName)
    if not profession then
        PropFramework:DebugPrint("Profession not found: " .. professionName)
        return false
    end
    
    table.insert(profession.items, {type = itemType, count = count or 1})
    return true
end

function PropFramework.Professions:ApplyToPlayer(player, professionName)
    local profession = self:Get(professionName)
    if not profession then
        PropFramework:DebugPrint("Profession not found: " .. professionName)
        return false
    end
    
    for perk, xp in pairs(profession.xp) do
        local perkObj = Perks[perk]
        if perkObj then
            player:getXp():AddXP(perkObj, xp)
        end
    end
    
    for _, trait in ipairs(profession.traits) do
        player:getTraits():add(trait)
    end
    
    local inventory = player:getInventory()
    for _, item in ipairs(profession.items) do
        for i = 1, item.count do
            inventory:AddItem(item.type)
        end
    end
    
    PropFramework:DebugPrint("Applied profession " .. professionName .. " to player")
    return true
end

function PropFramework.Professions:Exists(name)
    return self.Registry[name] ~= nil
end

function PropFramework.Professions:Unregister(name)
    if self.Registry[name] then
        self.Registry[name] = nil
        PropFramework:DebugPrint("Unregistered profession: " .. name)
        return true
    end
    return false
end

PropFramework.Modules.Professions = true
