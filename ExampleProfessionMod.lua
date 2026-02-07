
require "PropFramework_Core"
require "PropFramework_Professions"
require "PropFramework_Skills"
require "PropFramework_Items"
require "PropFramework_Events"

local ExampleProfessionMod = {}

function ExampleProfessionMod:Init()
    print("[ExampleMod] Initializing...")
    
    if not PropFramework:IsLoaded() then
        print("[ExampleMod] Error: PropFramework not loaded!")
        return
    end
    
    self:RegisterProfessions()
    
    self:SetupEvents()
    
    print("[ExampleMod] Initialization complete!")
end

function ExampleProfessionMod:RegisterProfessions()
    
    PropFramework.Professions:Register({
        name = "Survivalist",
        type = "profession",
        cost = 4,
        description = "An experienced outdoorsman with hunting and foraging skills.",
        xp = {
            Woodwork = 2,
            Fishing = 2,
            Trapping = 3,
            Foraging = 3,
            Cooking = 1
        },
        traits = {"Outdoorsman", "Keen Hearing"},
        recipes = {
            "Make Trap Box",
            "Make Stick Trap",
            "Make Snare Trap"
        }
    })
    
    PropFramework.Professions:AddStartingItem("Survivalist", "Base.HuntingKnife", 1)
    PropFramework.Professions:AddStartingItem("Survivalist", "Base.Rope", 2)
    PropFramework.Professions:AddStartingItem("Survivalist", "Base.WaterBottle", 1)
    
    print("[ExampleMod] Registered Survivalist profession")
    
    PropFramework.Professions:Register({
        name = "AutoMechanic",
        type = "profession",
        cost = 6,
        description = "A skilled mechanic with expertise in vehicle repair and maintenance.",
        xp = {
            Mechanics = 4,
            Metalworking = 2,
            Electricity = 1
        },
        traits = {"Handy"},
        recipes = {
            "Fix Engine",
            "Repair Vehicle"
        }
    })
    
    PropFramework.Professions:AddStartingItem("AutoMechanic", "Base.Wrench", 1)
    PropFramework.Professions:AddStartingItem("AutoMechanic", "Base.Screwdriver", 1)
    PropFramework.Professions:AddStartingItem("AutoMechanic", "Base.LugWrench", 1)
    
    print("[ExampleMod] Registered AutoMechanic profession")
    
    PropFramework.Professions:Register({
        name = "CombatMedic",
        type = "profession",
        cost = 8,
        description = "Military medic trained in first aid and combat situations.",
        xp = {
            FirstAid = 5,
            Fitness = 2,
            Aiming = 2
        },
        traits = {"FastHealer", "FirstAid"},
        recipes = {
            "Make Bandage",
            "Make Splint"
        }
    })
    
    PropFramework.Professions:AddStartingItem("CombatMedic", "Base.FirstAidKit", 1)
    PropFramework.Professions:AddStartingItem("CombatMedic", "Base.Pills", 2)
    PropFramework.Professions:AddStartingItem("CombatMedic", "Base.Bandage", 5)
    
    print("[ExampleMod] Registered CombatMedic profession")
end

function ExampleProfessionMod:SetupEvents()
    
    PropFramework.Events:OnPlayerCreate(function(playerNum, player)
        print("[ExampleMod] Player created: " .. tostring(playerNum))
        
        if player:getDescriptor():getProfession() == "Survivalist" then
            PropFramework.Items:Give(player, "Base.Matches", 1)
            print("[ExampleMod] Gave bonus matches to Survivalist")
        end
    end)
    
    PropFramework.Events:OnLevelUp(function(player, perk, perkLevel)
        local perkName = tostring(perk)
        print("[ExampleMod] Player leveled up " .. perkName .. " to level " .. perkLevel)
        
        if perkName == "Trapping" and perkLevel == 5 then
            PropFramework.Items:Give(player, "Base.TrapBox", 1)
            player:Say("I've mastered trapping!")
        end
    end)
    
    PropFramework.Events:On("OnProfessionApplied", function(player, professionName)
        print("[ExampleMod] Profession applied: " .. professionName)
        
        if professionName == "CombatMedic" then
            PropFramework.Skills:GiveXP(player, "FirstAid", 500, false)
        end
    end)
end

function ExampleProfessionMod:ApplyTestProfession(playerNum, professionName)
    local player = getSpecificPlayer(playerNum)
    if player and PropFramework.Professions:Exists(professionName) then
        PropFramework.Professions:ApplyToPlayer(player, professionName)
        PropFramework.Events:TriggerProfessionApplied(player, professionName)
        print("[ExampleMod] Applied profession: " .. professionName)
    else
        print("[ExampleMod] Failed to apply profession: " .. tostring(professionName))
    end
end

function ExampleProfessionMod:ListProfessions()
    print("[ExampleMod] Registered Professions:")
    for name, prof in pairs(PropFramework.Professions:GetAll()) do
        print("  - " .. name .. " (Cost: " .. prof.cost .. ")")
    end
end

Events.OnGameStart.Add(function()
    ExampleProfessionMod:Init()
end)

_G.ExampleProfessionMod = ExampleProfessionMod
