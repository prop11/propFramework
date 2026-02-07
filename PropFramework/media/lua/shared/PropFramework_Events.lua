
require "PropFramework_Core"

PropFramework.Events = PropFramework.Events or {}
PropFramework.Events.Callbacks = {}
PropFramework.Events.Hooks = {}

function PropFramework.Events:On(eventName, callback, priority)
    if not eventName or not callback then
        return false
    end
    
    priority = priority or 5
    
    if not self.Callbacks[eventName] then
        self.Callbacks[eventName] = {}
    end
    
    table.insert(self.Callbacks[eventName], {
        callback = callback,
        priority = priority
    })
    
    table.sort(self.Callbacks[eventName], function(a, b)
        return a.priority > b.priority
    end)
    
    PropFramework:DebugPrint("Registered callback for event: " .. eventName)
    return true
end

function PropFramework.Events:Trigger(eventName, ...)
    if not self.Callbacks[eventName] then
        return
    end
    
    PropFramework:DebugPrint("Triggering event: " .. eventName)
    
    for _, callbackData in ipairs(self.Callbacks[eventName]) do
        local success, err = pcall(callbackData.callback, ...)
        if not success then
            print("[PropFramework] Error in event " .. eventName .. ": " .. tostring(err))
        end
    end
end

function PropFramework.Events:Clear(eventName)
    if self.Callbacks[eventName] then
        self.Callbacks[eventName] = nil
        PropFramework:DebugPrint("Cleared callbacks for event: " .. eventName)
        return true
    end
    return false
end

function PropFramework.Events:HookGame(gameEvent, callback)
    if not gameEvent or not callback then
        return false
    end
    
    Events[gameEvent].Add(callback)
    
    if not self.Hooks[gameEvent] then
        self.Hooks[gameEvent] = {}
    end
    table.insert(self.Hooks[gameEvent], callback)
    
    PropFramework:DebugPrint("Hooked into game event: " .. gameEvent)
    return true
end

function PropFramework.Events:UnhookGame(gameEvent, callback)
    if not gameEvent or not callback then
        return false
    end
    
    Events[gameEvent].Remove(callback)
    
    if self.Hooks[gameEvent] then
        for i, cb in ipairs(self.Hooks[gameEvent]) do
            if cb == callback then
                table.remove(self.Hooks[gameEvent], i)
                break
            end
        end
    end
    
    PropFramework:DebugPrint("Removed hook from game event: " .. gameEvent)
    return true
end

function PropFramework.Events:OnPlayerCreate(callback)
    return self:HookGame("OnCreatePlayer", callback)
end

function PropFramework.Events:OnPlayerDeath(callback)
    return self:HookGame("OnPlayerDeath", callback)
end

function PropFramework.Events:OnPlayerUpdate(callback)
    return self:HookGame("OnPlayerUpdate", callback)
end

function PropFramework.Events:OnItemPickup(callback)
    return self:HookGame("OnPickupItem", callback)
end

function PropFramework.Events:OnItemDrop(callback)
    return self:HookGame("OnDropItem", callback)
end

function PropFramework.Events:OnZombieKilled(callback)
    return self:HookGame("OnZombieDead", callback)
end

function PropFramework.Events:OnLevelUp(callback)
    return self:HookGame("LevelPerkUp", callback)
end

function PropFramework.Events:OnGameStart(callback)
    return self:HookGame("OnGameStart", callback)
end

function PropFramework.Events:OnSave(callback)
    return self:HookGame("OnSave", callback)
end

function PropFramework.Events:OnLoad(callback)
    return self:HookGame("OnLoad", callback)
end

function PropFramework.Events:TriggerProfessionApplied(player, professionName)
    self:Trigger("OnProfessionApplied", player, professionName)
end

function PropFramework.Events:TriggerTraitAdded(player, traitName)
    self:Trigger("OnTraitAdded", player, traitName)
end

function PropFramework.Events:TriggerRecipeLearned(player, recipeName)
    self:Trigger("OnRecipeLearned", player, recipeName)
end

function PropFramework.Events:Schedule(delay, callback, ...)
    local args = {...}
    
    local function scheduledCallback()
        callback(unpack(args))
    end
    
    PropFramework:DebugPrint("Scheduled event with delay: " .. delay)
    
    return true
end

function PropFramework.Events:Repeat(interval, callback, ...)
    local args = {...}
    
    local function repeatingCallback()
        callback(unpack(args))
    end
    
    PropFramework:DebugPrint("Created repeating event with interval: " .. interval)
    
    return true
end

PropFramework.Modules.Events = true
