
require "PropFramework_Core"

PropFramework.Utils = PropFramework.Utils or {}

function PropFramework.Utils:DeepCopy(original)
    local copy
    if type(original) == 'table' then
        copy = {}
        for key, value in next, original, nil do
            copy[PropFramework.Utils:DeepCopy(key)] = PropFramework.Utils:DeepCopy(value)
        end
        setmetatable(copy, PropFramework.Utils:DeepCopy(getmetatable(original)))
    else
        copy = original
    end
    return copy
end

function PropFramework.Utils:MergeTables(t1, t2)
    local result = self:DeepCopy(t1)
    for k, v in pairs(t2) do
        if type(v) == 'table' and type(result[k]) == 'table' then
            result[k] = self:MergeTables(result[k], v)
        else
            result[k] = v
        end
    end
    return result
end

function PropFramework.Utils:TableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function PropFramework.Utils:TableSize(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

function PropFramework.Utils:Split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

function PropFramework.Utils:Trim(str)
    return str:match("^%s*(.-)%s*$")
end

function PropFramework.Utils:StartsWith(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function PropFramework.Utils:EndsWith(str, suffix)
    return suffix == "" or str:sub(-#suffix) == suffix
end

function PropFramework.Utils:Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function PropFramework.Utils:Lerp(a, b, t)
    return a + (b - a) * t
end

function PropFramework.Utils:Round(num)
    return math.floor(num + 0.5)
end

function PropFramework.Utils:RoundToDecimal(num, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

function PropFramework.Utils:RandomFloat(min, max)
    return min + (math.random() * (max - min))
end

function PropFramework.Utils:RandomInt(min, max)
    return math.random(min, max)
end

function PropFramework.Utils:Percentage(value, max)
    if max == 0 then return 0 end
    return (value / max) * 100
end

function PropFramework.Utils:GetPlayerPosition(player)
    if not player then return nil end
    return {
        x = player:getX(),
        y = player:getY(),
        z = player:getZ()
    }
end

function PropFramework.Utils:DistanceBetweenPlayers(player1, player2)
    if not player1 or not player2 then return 0 end
    
    local x1, y1 = player1:getX(), player1:getY()
    local x2, y2 = player2:getX(), player2:getY()
    
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function PropFramework.Utils:Distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function PropFramework.Utils:IsPlayerNear(player, x, y, radius)
    if not player then return false end
    
    local px, py = player:getX(), player:getY()
    local distance = self:Distance(px, py, x, y)
    
    return distance <= radius
end

function PropFramework.Utils:GetPlayersInRadius(x, y, radius)
    local players = {}
    local allPlayers = getOnlinePlayers()
    
    for i = 0, allPlayers:size() - 1 do
        local player = allPlayers:get(i)
        if self:IsPlayerNear(player, x, y, radius) then
            table.insert(players, player)
        end
    end
    
    return players
end

function PropFramework.Utils:GetGameTime()
    local gameTime = getGameTime()
    return {
        hour = gameTime:getHour(),
        minute = gameTime:getMinutes(),
        day = gameTime:getDay(),
        month = gameTime:getMonth(),
        year = gameTime:getYear()
    }
end

function PropFramework.Utils:IsDaytime()
    local hour = getGameTime():getHour()
    return hour >= 6 and hour < 20
end

function PropFramework.Utils:IsNighttime()
    return not self:IsDaytime()
end

function PropFramework.Utils:FormatTime(hour, minute)
    return string.format("%02d:%02d", hour or 0, minute or 0)
end

function PropFramework.Utils:IsValidLocation(x, y, z)
    local square = getCell():getGridSquare(x, y, z)
    return square ~= nil
end

function PropFramework.Utils:IsIndoors(x, y, z)
    local square = getCell():getGridSquare(x, y, z)
    if square then
        return square:getRoom() ~= nil
    end
    return false
end

function PropFramework.Utils:GetNearestBuilding(x, y, z, radius)
    radius = radius or 20
    
    for dx = -radius, radius do
        for dy = -radius, radius do
            local square = getCell():getGridSquare(x + dx, y + dy, z)
            if square and square:getBuilding() then
                return square:getBuilding()
            end
        end
    end
    
    return nil
end

function PropFramework.Utils:IsValidPlayer(player)
    return player ~= nil and instanceof(player, "IsoPlayer")
end

function PropFramework.Utils:IsValidItem(item)
    return item ~= nil and instanceof(item, "InventoryItem")
end

function PropFramework.Utils:SerializeTable(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        local key = type(k) == "string" and string.format('"%s"', k) or tostring(k)
        local value
        
        if type(v) == "table" then
            value = self:SerializeTable(v)
        elseif type(v) == "string" then
            value = string.format('"%s"', v)
        else
            value = tostring(v)
        end
        
        result = result .. string.format("[%s]=%s,", key, value)
    end
    result = result .. "}"
    return result
end

function PropFramework.Utils:RGBToHex(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

function PropFramework.Utils:RandomColor()
    return {
        r = math.random(0, 255),
        g = math.random(0, 255),
        b = math.random(0, 255)
    }
end

PropFramework.Modules.Utils = true
