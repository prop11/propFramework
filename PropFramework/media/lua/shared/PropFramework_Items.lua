
require "PropFramework_Core"

PropFramework.Items = PropFramework.Items or {}
PropFramework.Items.CustomItems = {}

function PropFramework.Items:Give(player, itemType, count)
    if not player or not itemType then
        return false
    end
    
    count = count or 1
    local inventory = player:getInventory()
    
    for i = 1, count do
        local item = inventory:AddItem(itemType)
        if not item then
            PropFramework:DebugPrint("Failed to add item: " .. itemType)
            return false
        end
    end
    
    PropFramework:DebugPrint("Gave " .. count .. "x " .. itemType .. " to player")
    return true
end

function PropFramework.Items:Remove(player, itemType, count)
    if not player or not itemType then
        return false
    end
    
    count = count or 1
    local inventory = player:getInventory()
    
    for i = 1, count do
        local item = inventory:getFirstTypeRecurse(itemType)
        if item then
            inventory:Remove(item)
        else
            return false
        end
    end
    
    PropFramework:DebugPrint("Removed " .. count .. "x " .. itemType .. " from player")
    return true
end

function PropFramework.Items:Has(player, itemType, count)
    if not player or not itemType then
        return false
    end
    
    count = count or 1
    local inventory = player:getInventory()
    
    return inventory:getItemCountRecurse(itemType) >= count
end

function PropFramework.Items:Count(player, itemType)
    if not player or not itemType then
        return 0
    end
    
    local inventory = player:getInventory()
    return inventory:getItemCountRecurse(itemType)
end

function PropFramework.Items:GetFirst(player, itemType)
    if not player or not itemType then
        return nil
    end
    
    local inventory = player:getInventory()
    return inventory:getFirstTypeRecurse(itemType)
end

function PropFramework.Items:GetAll(player, itemType)
    if not player or not itemType then
        return {}
    end
    
    local items = {}
    local inventory = player:getInventory()
    local allItems = inventory:getItems()
    
    for i = 0, allItems:size() - 1 do
        local item = allItems:get(i)
        if item:getFullType() == itemType or item:getType() == itemType then
            table.insert(items, item)
        end
    end
    
    return items
end

function PropFramework.Items:SpawnAt(x, y, z, itemType, count)
    if not x or not y or not z or not itemType then
        return false
    end
    
    count = count or 1
    
    for i = 1, count do
        local item = instanceItem(itemType)
        if item then
            getCell():getGridSquare(x, y, z):AddWorldInventoryItem(item, 0.5, 0.5, 0)
        else
            PropFramework:DebugPrint("Failed to spawn item: " .. itemType)
            return false
        end
    end
    
    PropFramework:DebugPrint("Spawned " .. count .. "x " .. itemType .. " at " .. x .. "," .. y .. "," .. z)
    return true
end

function PropFramework.Items:RegisterCustom(itemType, data)
    if not itemType or not data then
        return false
    end
    
    self.CustomItems[itemType] = data
    PropFramework:DebugPrint("Registered custom item: " .. itemType)
    
    return true
end

function PropFramework.Items:GetCustomData(itemType)
    return self.CustomItems[itemType]
end

function PropFramework.Items:SetProperty(item, property, value)
    if not item or not property then
        return false
    end
    
    local modData = item:getModData()
    modData[property] = value
    
    return true
end

function PropFramework.Items:GetProperty(item, property)
    if not item or not property then
        return nil
    end
    
    local modData = item:getModData()
    return modData[property]
end

function PropFramework.Items:GiveWithProperties(player, itemType, properties)
    if not player or not itemType then
        return false
    end
    
    local inventory = player:getInventory()
    local item = inventory:AddItem(itemType)
    
    if not item then
        PropFramework:DebugPrint("Failed to add item: " .. itemType)
        return false
    end
    
    if properties then
        for key, value in pairs(properties) do
            self:SetProperty(item, key, value)
        end
    end
    
    PropFramework:DebugPrint("Gave " .. itemType .. " with custom properties")
    return true
end

function PropFramework.Items:Transfer(fromPlayer, toPlayer, itemType, count)
    if not fromPlayer or not toPlayer or not itemType then
        return false
    end
    
    count = count or 1
    
    if not self:Has(fromPlayer, itemType, count) then
        return false
    end
    
    if self:Remove(fromPlayer, itemType, count) then
        return self:Give(toPlayer, itemType, count)
    end
    
    return false
end

function PropFramework.Items:GetWeight(itemType)
    local item = instanceItem(itemType)
    if item then
        return item:getActualWeight()
    end
    return 0
end

function PropFramework.Items:IsFood(item)
    if not item then
        return false
    end
    return instanceof(item, "Food")
end

function PropFramework.Items:IsWeapon(item)
    if not item then
        return false
    end
    return instanceof(item, "HandWeapon")
end

function PropFramework.Items:GetCondition(item)
    if not item then
        return 0
    end
    return item:getCondition()
end

function PropFramework.Items:SetCondition(item, condition)
    if not item then
        return false
    end
    item:setCondition(condition)
    return true
end

PropFramework.Modules.Items = true
