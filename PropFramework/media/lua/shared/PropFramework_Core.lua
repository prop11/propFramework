
PropFramework = PropFramework or {}
PropFramework.Version = "1.0.0"
PropFramework.Build = 42

PropFramework.Modules = {
    Professions = false,
    Traits = false,
    Skills = false,
    Items = false,
    Recipes = false,
    UI = false,
    Events = false,
    Utils = false
}

PropFramework.Debug = false

function PropFramework:Initialize()
    print("=================================")
    print("PZ Framework Core v" .. self.Version)
    print("Build " .. self.Build .. " Compatible")
    print("=================================")
    
    for module, loaded in pairs(self.Modules) do
        if loaded then
            print("[PropFramework] Module loaded: " .. module)
        else
            print("[PropFramework] WARNING: Module not loaded: " .. module)
        end
    end
    
    print("=================================")
end

function PropFramework:DebugPrint(message)
    if self.Debug then
        print("[PropFramework DEBUG] " .. tostring(message))
    end
end

function PropFramework:GetVersion()
    return self.Version
end

function PropFramework:IsLoaded()
    return true
end

_G.PropFramework = PropFramework
