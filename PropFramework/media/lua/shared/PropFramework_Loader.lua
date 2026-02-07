
require "PropFramework_Core"

require "PropFramework_Professions"
require "PropFramework_Traits"
require "PropFramework_Skills"
require "PropFramework_Items"
require "PropFramework_Recipes"
require "PropFramework_Events"
require "PropFramework_Utils"
require "PropFramework_UI"

local function InitializeFramework()
    PropFramework:Initialize()
    
    SetupDefaultEventHandlers()
end

function SetupDefaultEventHandlers()
    
    Events.LevelPerkUp.Add(function(player, perk, perkLevel)
        local perkName = tostring(perk)
        PropFramework.Skills:TriggerLevelUp(player, perkName, perkLevel)
    end)
    
    Events.OnSave.Add(function()
        PropFramework:DebugPrint("Game saved")
    end)
    
    Events.OnLoad.Add(function()
        PropFramework:DebugPrint("Game loaded")
    end)
    
    Events.OnPlayerUpdate.Add(function(player)
        if player then
            PropFramework.UI:ProcessNotificationQueue(player)
        end
    end)
end

Events.OnGameStart.Add(InitializeFramework)

print("[PropFramework] Loader executed")
