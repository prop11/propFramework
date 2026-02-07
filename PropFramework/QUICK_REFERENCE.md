# PropFramework Quick Reference

# Quick Start

```lua
-- In your mod file
require "PropFramework_Core"
require "PropFramework_Professions"

-- Register a profession
PropFramework.Professions:Register({
    name = "MyJob",
    cost = 4,
    xp = {Carpentry = 3},
    traits = {"Handy"}
})

-- Add starting items
PropFramework.Professions:AddStartingItem("MyJob", "Base.Hammer", 1)
```

# Most Common Functions

# Professions
```lua
PropFramework.Professions:Register({name, cost, xp, traits, recipes})
PropFramework.Professions:ApplyToPlayer(player, professionName)
PropFramework.Professions:AddStartingItem(professionName, itemType, count)
```

# Skills
```lua
PropFramework.Skills:GiveXP(player, "Carpentry", 1000)
PropFramework.Skills:SetLevel(player, "Carpentry", 5)
PropFramework.Skills:GetLevel(player, "Carpentry")
```

# Items
```lua
PropFramework.Items:Give(player, "Base.Axe", 1)
PropFramework.Items:Has(player, "Base.Hammer", 1)
PropFramework.Items:Remove(player, "Base.Nails", 10)
PropFramework.Items:Count(player, "Base.Nails")
```

# Traits
```lua
PropFramework.Traits:Register({name, cost, description})
PropFramework.Traits:AddToPlayer(player, "MyTrait")
PropFramework.Traits:PlayerHas(player, "Handy")
```

# Events
```lua
PropFramework.Events:OnPlayerCreate(function(playerNum, player)
    -- Your code
end)

PropFramework.Events:OnLevelUp(function(player, perk, level)
    -- Your code
end)

PropFramework.Events:On("CustomEvent", function(data)
    -- Your code
end)

PropFramework.Events:Trigger("CustomEvent", data)
```

# Recipes
```lua
PropFramework.Recipes:Register({
    name = "CraftItem",
    skills = {Carpentry = 3},
    ingredients = {
        {type = "Base.Plank", count = 4}
    },
    result = "Base.WoodenWall"
})

PropFramework.Recipes:GrantKnowledge(player, "CraftItem")
```

# Utils
```lua
-- Math
PropFramework.Utils:Clamp(value, min, max)
PropFramework.Utils:Round(num)
PropFramework.Utils:RandomInt(min, max)

-- Tables
PropFramework.Utils:DeepCopy(table)
PropFramework.Utils:TableContains(table, value)

-- Strings
PropFramework.Utils:Split(str, delimiter)
PropFramework.Utils:Trim(str)

-- Player
PropFramework.Utils:GetPlayerPosition(player)
PropFramework.Utils:DistanceBetweenPlayers(p1, p2)
PropFramework.Utils:GetPlayersInRadius(x, y, radius)

-- Time
PropFramework.Utils:GetGameTime()
PropFramework.Utils:IsDaytime()
```

# UI
```lua
PropFramework.UI:ShowNotification(player, "Message", duration)
PropFramework.UI:DisplayText(player, "Text", x, y, duration)
```

# Common Patterns

# Create Complete Profession
```lua
PropFramework.Professions:Register({
    name = "Mechanic",
    cost = 6,
    description = "Car expert",
    xp = {
        Mechanics = 4,
        Metalworking = 2
    },
    traits = {"Handy"},
    recipes = {"FixEngine"}
})

PropFramework.Professions:AddStartingItem("Mechanic", "Base.Wrench", 1)
PropFramework.Professions:AddStartingItem("Mechanic", "Base.Screwdriver", 1)
```

# Reward on Milestone
```lua
PropFramework.Events:OnLevelUp(function(player, perk, level)
    if perk == "Carpentry" and level == 5 then
        PropFramework.Items:Give(player, "Base.Saw", 1)
        PropFramework.UI:ShowNotification(player, "Mastery reward!")
    end
end)
```

# Check Multiple Requirements
```lua
local canCraft = PropFramework.Skills:GetLevel(player, "Carpentry") >= 3
    and PropFramework.Items:Has(player, "Base.Hammer", 1)
    and PropFramework.Items:Has(player, "Base.Nails", 10)
```

# Debug Mode
```lua
PropFramework.Debug = true  -- Enable verbose logging
```

# Getting Player Reference
```lua
-- In most events
function callback(player)
    -- player is already provided
end

-- Manually get player
local player = getSpecificPlayer(0)  -- Player 0
```

# Available Skill Names (Common)
- Carpentry, Woodwork, Farming, Fishing, Trapping, Foraging
- Mechanics, Electricity, Metalworking, Tailoring
- Cooking, FirstAid
- Fitness, Strength, Sprinting, Lightfooted, Nimble, Sneak
- Aiming, Reloading, Axe, Blunt, SmallBlunt, LongBlade, SmallBlade, Spear, Maintenance

# File Structure
```
YourMod/
 mod.info
 media/
     lua/
         shared/          # Code that runs on both client and server
            YourMod.lua
         client/          # Client-only code
             YourMod.lua
```

# Integration Example
```lua
-- YourMod.lua
require "PropFramework_Core"
require "PropFramework_Professions"
require "PropFramework_Events"

local MyMod = {}

function MyMod:Init()
    if not PropFramework:IsLoaded() then
        print("Framework not loaded!")
        return
    end

    -- Your initialization
    self:RegisterProfessions()
    self:SetupEvents()
end

function MyMod:RegisterProfessions()
    PropFramework.Professions:Register({
        name = "MyProf",
        cost = 4,
        xp = {Carpentry = 2}
    })
end

function MyMod:SetupEvents()
    PropFramework.Events:OnPlayerCreate(function(pNum, player)
        print("Player created")
    end)
end

Events.OnGameStart.Add(function()
    MyMod:Init()
end)
```

# Console Commands (for testing)
```lua
-- Access your mod from console
/additem Base.Hammer 1

-- Call your mod functions
lua: YourMod:TestFunction()

-- Get player
lua: player = getSpecificPlayer(0)

-- Test profession
lua: PropFramework.Professions:ApplyToPlayer(player, "MyProf")
```
