# PropFramework - Build 42

A comprehensive framework for Project Zomboid Build 42 modding that provides reusable functions for professions, traits, skills, items, recipes, events, and utilities.

# Features

- Profession Management: Register and manage custom professions with skills, traits, and starting items
- Trait System: Create custom traits with requirements, effects, and mutual exclusivity
- Skills Module: Handle skill XP, leveling, and custom multipliers
- Items Module: Item spawning, management, and custom properties
- Recipes Module: Register crafting recipes with skill requirements
- Events Module: Custom event system with priority-based callbacks
- Utils Module: Extensive utility functions for common tasks

# Installation

1. Copy the entire mod folder to your Project Zomboid mods directory:
   - Windows: `C:\Users\YourUsername\Zomboid\mods\`
   - Linux: `~/.zomboid/mods/`
   - Mac: `~/Library/Application Support/Zomboid/mods/`

2. Enable the mod in the game's mod menu

# Usage

# Basic Setup

```lua
-- Require the framework in your mod
require "PropFramework_Core"
require "PropFramework_Professions"
require "PropFramework_Skills"
require "PropFramework_Items"

-- Check if framework is loaded
if PropFramework:IsLoaded() then
    print("Framework loaded successfully!")
end
```

# Creating a Profession

```lua
-- Register a new profession
PropFramework.Professions:Register({
    name = "MyProfession",
    type = "profession",
    cost = 4,
    description = "A custom profession",
    xp = {
        Woodwork = 2,
        Carpentry = 3
    },
    traits = {"Handy", "FastLearner"},
    recipes = {"Make Wooden Wall"}
})

-- Add starting items
PropFramework.Professions:AddStartingItem("MyProfession", "Base.Hammer", 1)
PropFramework.Professions:AddStartingItem("MyProfession", "Base.Nails", 50)

-- Apply profession to player
PropFramework.Professions:ApplyToPlayer(player, "MyProfession")
```

# Creating Custom Traits

```lua
-- Register a custom trait
PropFramework.Traits:Register({
    name = "NightOwl",
    cost = -2,
    description = "Performs better at night",
    mutuallyExclusive = {"EarlyBird"},
    effects = {
        onAdd = function(player)
            -- Custom logic when trait is added
            print("Night Owl trait added")
        end
    }
})

-- Add trait to player
PropFramework.Traits:AddToPlayer(player, "NightOwl")
```

# Managing Skills

```lua
-- Give XP to a skill
PropFramework.Skills:GiveXP(player, "Carpentry", 1000, true)

-- Set skill level directly
PropFramework.Skills:SetLevel(player, "Carpentry", 5)

-- Get current skill level
local level = PropFramework.Skills:GetLevel(player, "Carpentry")

-- Set custom XP multiplier
PropFramework.Skills:SetXPMultiplier("Carpentry", 2.0)

-- Register level-up callback
PropFramework.Skills:OnLevelUp("Carpentry", function(player, newLevel)
    print("Carpentry reached level " .. newLevel)
end)
```

# Item Management

```lua
-- Give items to player
PropFramework.Items:Give(player, "Base.Axe", 1)

-- Check if player has item
if PropFramework.Items:Has(player, "Base.Hammer", 1) then
    print("Player has a hammer")
end

-- Count items
local count = PropFramework.Items:Count(player, "Base.Nails")

-- Give item with custom properties
PropFramework.Items:GiveWithProperties(player, "Base.Axe", {
    customName = "Legendary Axe",
    customDurability = 100
})

-- Spawn item at location
PropFramework.Items:SpawnAt(x, y, z, "Base.Shotgun", 1)
```

# Recipe System

```lua
-- Register a recipe
PropFramework.Recipes:Register({
    name = "CraftSuperTool",
    category = "Tools",
    time = 200,
    skills = {
        Metalworking = 5,
        Mechanics = 3
    },
    ingredients = {
        {type = "Base.ScrapMetal", count = 5},
        {type = "Base.Wire", count = 2}
    },
    result = "Base.Wrench",
    resultCount = 1
})

-- Check if player can craft
if PropFramework.Recipes:CanCraft(player, "CraftSuperTool") then
    print("Player can craft this recipe")
end

-- Grant recipe knowledge
PropFramework.Recipes:GrantKnowledge(player, "CraftSuperTool")
```

# Event System

```lua
-- Register custom event
PropFramework.Events:On("MyCustomEvent", function(data)
    print("Custom event triggered with data:", data)
end, 5) -- Priority 5

-- Trigger event
PropFramework.Events:Trigger("MyCustomEvent", "Hello World")

-- Hook into game events
PropFramework.Events:OnPlayerCreate(function(playerNum, player)
    print("Player created:", playerNum)
end)

PropFramework.Events:OnZombieKilled(function(zombie)
    print("Zombie killed!")
end)

-- Convenience wrappers
PropFramework.Events:OnLevelUp(function(player, perk, level)
    print("Level up:", perk, level)
end)
```

# Utility Functions

```lua
-- Table utilities
local copy = PropFramework.Utils:DeepCopy(originalTable)
local merged = PropFramework.Utils:MergeTables(table1, table2)

-- String utilities
local parts = PropFramework.Utils:Split("hello,world", ",")
local trimmed = PropFramework.Utils:Trim("  text  ")

-- Math utilities
local clamped = PropFramework.Utils:Clamp(value, 0, 100)
local rounded = PropFramework.Utils:Round(3.7)
local random = PropFramework.Utils:RandomFloat(1.0, 10.0)

-- Player utilities
local distance = PropFramework.Utils:DistanceBetweenPlayers(player1, player2)
local nearby = PropFramework.Utils:GetPlayersInRadius(x, y, 10)

-- Time utilities
local gameTime = PropFramework.Utils:GetGameTime()
if PropFramework.Utils:IsDaytime() then
    print("It's daytime!")
end

-- World utilities
if PropFramework.Utils:IsIndoors(x, y, z) then
    print("Location is indoors")
end
```

# API Reference

# PropFramework.Professions

- `Register(data)` - Register a new profession
- `Get(name)` - Get profession by name
- `GetAll()` - Get all professions
- `AddSkillXP(professionName, perk, xpAmount)` - Add skill XP to profession
- `AddTrait(professionName, trait)` - Add trait to profession
- `AddRecipe(professionName, recipe)` - Add recipe to profession
- `AddStartingItem(professionName, itemType, count)` - Add starting item
- `ApplyToPlayer(player, professionName)` - Apply profession to player
- `Exists(name)` - Check if profession exists

# PropFramework.Traits

- `Register(data)` - Register a new trait
- `Get(name)` - Get trait by name
- `GetAll()` - Get all traits
- `AddToPlayer(player, traitName)` - Add trait to player
- `RemoveFromPlayer(player, traitName)` - Remove trait from player
- `PlayerHas(player, traitName)` - Check if player has trait
- `CheckRequirements(player, traitName)` - Check trait requirements
- `SetMutuallyExclusive(traitName, exclusiveTraits)` - Set mutually exclusive traits

# PropFramework.Skills

- `GiveXP(player, perkName, amount, applyMultipliers)` - Give XP to player
- `SetLevel(player, perkName, level)` - Set skill level
- `GetLevel(player, perkName)` - Get skill level
- `GetXP(player, perkName)` - Get current XP
- `SetXPMultiplier(perkName, multiplier)` - Set XP multiplier
- `OnLevelUp(perkName, callback)` - Register level-up callback
- `MeetsRequirement(player, requirements)` - Check skill requirements
- `GetAllLevels(player)` - Get all skill levels

# PropFramework.Items

- `Give(player, itemType, count)` - Give item to player
- `Remove(player, itemType, count)` - Remove item from player
- `Has(player, itemType, count)` - Check if player has item
- `Count(player, itemType)` - Count items in inventory
- `SpawnAt(x, y, z, itemType, count)` - Spawn item at location
- `GiveWithProperties(player, itemType, properties)` - Give item with custom properties
- `SetProperty(item, property, value)` - Set item property
- `GetProperty(item, property)` - Get item property

# PropFramework.Recipes

- `Register(data)` - Register a recipe
- `Get(name)` - Get recipe by name
- `GetAll()` - Get all recipes
- `CanCraft(player, recipeName)` - Check if player can craft
- `GrantKnowledge(player, recipeName)` - Grant recipe knowledge
- `PlayerKnows(player, recipeName)` - Check if player knows recipe

# PropFramework.Events

- `On(eventName, callback, priority)` - Register event callback
- `Trigger(eventName, ...)` - Trigger event
- `HookGame(gameEvent, callback)` - Hook into game event
- Convenience wrappers: `OnPlayerCreate`, `OnPlayerDeath`, `OnZombieKilled`, `OnLevelUp`, etc.

# PropFramework.Utils

Comprehensive utility functions for tables, strings, math, players, time, and world operations.

# Example Mod

See `ExampleProfessionMod.lua` for a complete example of how to use the framework to create custom professions.

# Debug Mode

Enable debug mode for verbose logging:

```lua
PropFramework.Debug = true
```

# Compatibility

- Build: 42 (unstable)
- Multiplayer: Compatible
- Saved Games: Safe to add/remove

# Support

For issues, questions, or contributions, please visit the GitHub repository.

# License

This framework is provided as-is for Project Zomboid modding purposes.
