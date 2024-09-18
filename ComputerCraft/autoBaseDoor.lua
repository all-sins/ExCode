throttle = 1
rsSide = "bottom"
whitelistNames = {"OG_Tsu", "Fir33y3", "oliver640", "Domartas", "StromHD", "ELDAM44", "HutMatter", "SnxpeMyBoy_"}
sensor = peripheral.wrap("top")
monitor = peripheral.wrap("left")
xRes, yRes = monitor.getSize()
monitor.setTextScale(1)
monitor.clear()
monitor.setCursorPos(1,1)
cursorPosX, cursorPosY = monitor.getCursorPos()

function writeln(msg)
    cursorPosX, cursorPosY = monitor.getCursorPos()
    if cursorPosY > yRes then
        monitor.clear()
        cursorPosY = 1
    end
    monitor.setCursorPos(1, cursorPosY)
    monitor.write(msg)
    monitor.setCursorPos(1, cursorPosY + 1)
end

function contains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function anyContains(list1, list2)
    for _, element in ipairs(list1) do
        if contains(list2, element) then
            return true
        end
    end
    return false
end

while true do
    players = sensor.getPlayers()
    detectedNames = {}
    
    for _, player in ipairs(players) do
        local name = player.name
        detectedNames[#detectedNames + 1] = name
    end
    
    stringBuilder = ""
    for _, name in ipairs(detectedNames) do
        stringBuilder = stringBuilder..name.." "
    end
    writeln(stringBuilder)
    
    if anyContains(detectedNames, whitelistNames) then
        print("TEAM_PLAYER_PRESENT")
        redstone.setAnalogOutput(rsSide, 15)
    else
        print("IDLE_STATE")
        redstone.setAnalogOutput(rsSide, 0)
    end
    
    os.sleep(throttle)
end
