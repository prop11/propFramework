
require "PropFramework_Core"

PropFramework.Recipes = PropFramework.Recipes or {}
PropFramework.Recipes.Registry = {}

function PropFramework.Recipes:Register(data)
    if not data or not data.name then
        error("[PropFramework] Recipe registration failed: name is required")
        return false
    end
    
    local recipe = {
        name = data.name,
        category = data.category or "General",
        time = data.time or 100,
        skills = data.skills or {},
        ingredients = data.ingredients or {},
        result = data.result,
        resultCount = data.resultCount or 1,
        onCreate = data.onCreate or nil,
        requiresHeat = data.requiresHeat or false,
        requiresWater = data.requiresWater or false,
        requiresContainer = data.requiresContainer or false
    }
    
    self.Registry[data.name] = recipe
    PropFramework:DebugPrint("Registered recipe: " .. data.name)
    
    return true
end

function PropFramework.Recipes:Get(name)
    return self.Registry[name]
end

function PropFramework.Recipes:GetAll()
    return self.Registry
end

function PropFramework.Recipes:GetByCategory(category)
    local recipes = {}
    
    for name, recipe in pairs(self.Registry) do
        if recipe.category == category then
            table.insert(recipes, recipe)
        end
    end
    
    return recipes
end

function PropFramework.Recipes:CanCraft(player, recipeName)
    local recipe = self:Get(recipeName)
    if not recipe then
        return false
    end
    
    for skillName, requiredLevel in pairs(recipe.skills) do
        local perk = Perks[skillName]
        if perk then
            local playerLevel = player:getPerkLevel(perk)
            if playerLevel < requiredLevel then
                return false
            end
        end
    end
    
    local inventory = player:getInventory()
    for _, ingredient in ipairs(recipe.ingredients) do
        local count = inventory:getItemCountRecurse(ingredient.type)
        if count < ingredient.count then
            return false
        end
    end
    
    return true
end

function PropFramework.Recipes:AddIngredient(recipeName, itemType, count)
    local recipe = self:Get(recipeName)
    if not recipe then
        return false
    end
    
    table.insert(recipe.ingredients, {type = itemType, count = count or 1})
    return true
end

function PropFramework.Recipes:SetSkillRequirement(recipeName, skillName, level)
    local recipe = self:Get(recipeName)
    if not recipe then
        return false
    end
    
    recipe.skills[skillName] = level
    return true
end

function PropFramework.Recipes:Exists(name)
    return self.Registry[name] ~= nil
end

function PropFramework.Recipes:Unregister(name)
    if self.Registry[name] then
        self.Registry[name] = nil
        PropFramework:DebugPrint("Unregistered recipe: " .. name)
        return true
    end
    return false
end

function PropFramework.Recipes:GrantKnowledge(player, recipeName)
    local recipe = self:Get(recipeName)
    if not recipe then
        return false
    end
    
    player:getKnownRecipes():add(recipeName)
    PropFramework:DebugPrint("Granted recipe knowledge: " .. recipeName)
    
    return true
end

function PropFramework.Recipes:RemoveKnowledge(player, recipeName)
    player:getKnownRecipes():remove(recipeName)
    PropFramework:DebugPrint("Removed recipe knowledge: " .. recipeName)
    
    return true
end

function PropFramework.Recipes:PlayerKnows(player, recipeName)
    return player:getKnownRecipes():contains(recipeName)
end

function PropFramework.Recipes:GetCraftableRecipes(player)
    local craftable = {}
    
    for name, recipe in pairs(self.Registry) do
        if self:CanCraft(player, name) then
            table.insert(craftable, recipe)
        end
    end
    
    return craftable
end

PropFramework.Modules.Recipes = true
