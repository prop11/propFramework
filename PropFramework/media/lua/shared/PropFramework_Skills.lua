
require "PropFramework_Core"

PropFramework.Skills = PropFramework.Skills or {}
PropFramework.Skills.CustomMultipliers = {}
PropFramework.Skills.LevelUpCallbacks = {}

function PropFramework.Skills:GiveXP(player, perkName, amount, applyMultipliers)
    if not player or not perkName or not amount then
        return false
    end
    
    local perk = Perks[perkName]
    if not perk then
        PropFramework:DebugPrint("Perk not found: " .. perkName)
        return false
    end
    
    local finalAmount = amount
    
    if applyMultipliers and self.CustomMultipliers[perkName] then
        finalAmount = finalAmount * self.CustomMultipliers[perkName]
    end
    
    player:getXp():AddXP(perk, finalAmount)
    PropFramework:DebugPrint("Gave " .. finalAmount .. " XP to " .. perkName)
    
    return true
end

function PropFramework.Skills:SetLevel(player, perkName, level)
    if not player or not perkName or not level then
        return false
    end
    
    local perk = Perks[perkName]
    if not perk then
        PropFramework:DebugPrint("Perk not found: " .. perkName)
        return false
    end
    
    player:getXp():setXPToLevel(perk, level)
    PropFramework:DebugPrint("Set " .. perkName .. " level to " .. level)
    
    return true
end

function PropFramework.Skills:GetLevel(player, perkName)
    if not player or not perkName then
        return 0
    end
    
    local perk = Perks[perkName]
    if not perk then
        PropFramework:DebugPrint("Perk not found: " .. perkName)
        return 0
    end
    
    return player:getPerkLevel(perk)
end

function PropFramework.Skills:GetXP(player, perkName)
    if not player or not perkName then
        return 0
    end
    
    local perk = Perks[perkName]
    if not perk then
        PropFramework:DebugPrint("Perk not found: " .. perkName)
        return 0
    end
    
    return player:getXp():getXP(perk)
end

function PropFramework.Skills:SetXPMultiplier(perkName, multiplier)
    if not perkName or not multiplier then
        return false
    end
    
    self.CustomMultipliers[perkName] = multiplier
    PropFramework:DebugPrint("Set XP multiplier for " .. perkName .. " to " .. multiplier)
    
    return true
end

function PropFramework.Skills:GetXPMultiplier(perkName)
    return self.CustomMultipliers[perkName] or 1.0
end

function PropFramework.Skills:GetXPForNextLevel(currentLevel)
    return 75 + (currentLevel * 25)
end

function PropFramework.Skills:GetTotalXPForLevel(targetLevel)
    local total = 0
    for level = 0, targetLevel - 1 do
        total = total + self:GetXPForNextLevel(level)
    end
    return total
end

function PropFramework.Skills:MeetsRequirement(player, requirements)
    if not requirements then
        return true
    end
    
    for perkName, requiredLevel in pairs(requirements) do
        local currentLevel = self:GetLevel(player, perkName)
        if currentLevel < requiredLevel then
            return false
        end
    end
    
    return true
end

function PropFramework.Skills:OnLevelUp(perkName, callback)
    if not self.LevelUpCallbacks[perkName] then
        self.LevelUpCallbacks[perkName] = {}
    end
    
    table.insert(self.LevelUpCallbacks[perkName], callback)
    PropFramework:DebugPrint("Registered level-up callback for " .. perkName)
end

function PropFramework.Skills:TriggerLevelUp(player, perkName, newLevel)
    if self.LevelUpCallbacks[perkName] then
        for _, callback in ipairs(self.LevelUpCallbacks[perkName]) do
            callback(player, newLevel)
        end
    end
end

function PropFramework.Skills:GetAllLevels(player)
    local skills = {}
    
    for perkName, perk in pairs(Perks) do
        local level = self:GetLevel(player, perkName)
        if level > 0 then
            skills[perkName] = level
        end
    end
    
    return skills
end

function PropFramework.Skills:GrantMultipleSkills(player, skillsTable)
    for perkName, level in pairs(skillsTable) do
        self:SetLevel(player, perkName, level)
    end
    
    PropFramework:DebugPrint("Granted multiple skills to player")
    return true
end

function PropFramework.Skills:ApplyTemporaryBoost(player, perkName, multiplier, duration)
    local originalMultiplier = self:GetXPMultiplier(perkName)
    self:SetXPMultiplier(perkName, multiplier)
    
    PropFramework:DebugPrint("Applied temporary boost to " .. perkName)
    
    return true
end

PropFramework.Modules.Skills = true
