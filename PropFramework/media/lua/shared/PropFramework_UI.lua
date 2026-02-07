
require "PropFramework_Core"

PropFramework.UI = PropFramework.UI or {}
PropFramework.UI.Windows = {}
PropFramework.UI.Notifications = {}

function PropFramework.UI:ShowNotification(player, message, duration)
    if not player or not message then
        return false
    end
    
    duration = duration or 3.0
    
    player:getModData().PropFramework_Notifications = player:getModData().PropFramework_Notifications or {}
    
    table.insert(player:getModData().PropFramework_Notifications, {
        message = message,
        duration = duration,
        timestamp = getTimestamp()
    })
    
    player:Say(message)
    
    PropFramework:DebugPrint("Showed notification: " .. message)
    return true
end

function PropFramework.UI:ShowTooltip(text, x, y)
    if not text then
        return false
    end
    
    PropFramework:DebugPrint("Tooltip: " .. text)
    return true
end

function PropFramework.UI:AddContextOption(context, text, target, onClick)
    if not context or not text then
        return false
    end
    
    local option = context:addOption(text, target, onClick)
    
    PropFramework:DebugPrint("Added context option: " .. text)
    return option
end

function PropFramework.UI:CreateDebugWindow(title, width, height)
    local window = {
        title = title or "Debug Window",
        width = width or 400,
        height = height or 300,
        visible = false,
        lines = {}
    }
    
    self.Windows[title] = window
    
    PropFramework:DebugPrint("Created debug window: " .. title)
    return window
end

function PropFramework.UI:DebugWindowAddLine(windowTitle, text)
    local window = self.Windows[windowTitle]
    if not window then
        return false
    end
    
    table.insert(window.lines, text)
    
    if #window.lines > 50 then
        table.remove(window.lines, 1)
    end
    
    return true
end

function PropFramework.UI:ToggleDebugWindow(windowTitle)
    local window = self.Windows[windowTitle]
    if not window then
        return false
    end
    
    window.visible = not window.visible
    return window.visible
end

function PropFramework.UI:DisplayText(player, text, x, y, duration)
    if not player or not text then
        return false
    end
    
    x = x or 0.5
    y = y or 0.1
    duration = duration or 3.0
    
    player:getModData().PropFramework_DisplayText = {
        text = text,
        x = x,
        y = y,
        duration = duration,
        timestamp = getTimestamp()
    }
    
    PropFramework:DebugPrint("Displaying text: " .. text)
    return true
end

function PropFramework.UI:CreateProgressBar(x, y, width, height)
    local progressBar = {
        x = x or 0.4,
        y = y or 0.5,
        width = width or 200,
        height = height or 20,
        progress = 0,
        visible = false,
        label = ""
    }
    
    return progressBar
end

function PropFramework.UI:UpdateProgressBar(progressBar, progress, label)
    if not progressBar then
        return false
    end
    
    progressBar.progress = PropFramework.Utils:Clamp(progress, 0, 1)
    if label then
        progressBar.label = label
    end
    
    return true
end

function PropFramework.UI:ShowConfirmDialog(player, title, text, onYes, onNo)
    if not player or not text then
        return false
    end
    
    PropFramework:DebugPrint("Showing confirm dialog: " .. text)
    
    player:getModData().PropFramework_ConfirmDialog = {
        title = title or "Confirm",
        text = text,
        onYes = onYes,
        onNo = onNo
    }
    
    return true
end

function PropFramework.UI:ShowInputDialog(player, title, defaultText, onConfirm)
    if not player then
        return false
    end
    
    PropFramework:DebugPrint("Showing input dialog: " .. (title or "Input"))
    
    player:getModData().PropFramework_InputDialog = {
        title = title or "Input",
        defaultText = defaultText or "",
        onConfirm = onConfirm
    }
    
    return true
end

function PropFramework.UI:CreateHealthBar(entity)
    if not entity then
        return nil
    end
    
    local healthBar = {
        entity = entity,
        visible = true,
        color = {r = 0, g = 255, b = 0}
    }
    
    return healthBar
end

function PropFramework.UI:GetHealthPercentage(entity)
    if not entity then
        return 0
    end
    
    local bodyDamage = entity:getBodyDamage()
    if bodyDamage then
        local health = bodyDamage:getHealth()
        local maxHealth = bodyDamage:getHealthFromFood()
        
        if maxHealth > 0 then
            return (health / maxHealth) * 100
        end
    end
    
    return 100
end

function PropFramework.UI:ColorGreen()
    return {r = 0, g = 255, b = 0}
end

function PropFramework.UI:ColorRed()
    return {r = 255, g = 0, b = 0}
end

function PropFramework.UI:ColorYellow()
    return {r = 255, g = 255, b = 0}
end

function PropFramework.UI:ColorBlue()
    return {r = 0, g = 0, b = 255}
end

function PropFramework.UI:ColorWhite()
    return {r = 255, g = 255, b = 255}
end

function PropFramework.UI:ColorLerp(color1, color2, t)
    return {
        r = PropFramework.Utils:Lerp(color1.r, color2.r, t),
        g = PropFramework.Utils:Lerp(color1.g, color2.g, t),
        b = PropFramework.Utils:Lerp(color1.b, color2.b, t)
    }
end

function PropFramework.UI:GetHealthColor(percentage)
    if percentage > 75 then
        return self:ColorGreen()
    elseif percentage > 50 then
        return self:ColorLerp(self:ColorYellow(), self:ColorGreen(), (percentage - 50) / 25)
    elseif percentage > 25 then
        return self:ColorLerp(self:ColorRed(), self:ColorYellow(), (percentage - 25) / 25)
    else
        return self:ColorRed()
    end
end

function PropFramework.UI:ColorText(text, color)
    if not text then
        return ""
    end
    
    return text
end

function PropFramework.UI:CreateIcon(texturePath)
    return {
        texture = texturePath,
        width = 32,
        height = 32
    }
end

function PropFramework.UI:QueueNotification(player, message)
    if not player or not message then
        return false
    end
    
    player:getModData().PropFramework_NotificationQueue = player:getModData().PropFramework_NotificationQueue or {}
    table.insert(player:getModData().PropFramework_NotificationQueue, message)
    
    return true
end

function PropFramework.UI:ProcessNotificationQueue(player)
    if not player then
        return
    end
    
    local queue = player:getModData().PropFramework_NotificationQueue
    if not queue or #queue == 0 then
        return
    end
    
    local message = table.remove(queue, 1)
    self:ShowNotification(player, message)
end

PropFramework.Modules.UI = true
