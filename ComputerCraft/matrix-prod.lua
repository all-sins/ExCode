local monitor = peripheral.wrap("bottom")
if not monitor then
  error("Monitor not found on 'bottom'")
end

local monitorX, monitorY = monitor.getSize()
if monitorX < 1 or monitorY < 1 then
  error("Invalid monitor size")
end

local array = {}
local charArray = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'}
local colorArray = {colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow, colors.lime, colors.pink, colors.gray, colors.lightGray, colors.cyan, colors.purple, colors.blue, colors.brown, colors.green, colors.red}
local msg = "CyberCrib"
local msgLen = #msg
local midX = math.floor((monitorX - msgLen) / 2)
local midY = math.floor(monitorY / 2)

monitor.clear()

-- Initialize array.
for x = 1, monitorX do
  array[x] = {}
  for y = 1, monitorY do
    array[x][y] = ' '
  end
end

while true do
  while redstone.getInput("right") do
    -- Fill first row of array with random chars.
    for i = 1, #array do
      if math.random(1, 10) == 1 then
        array[i][1] = charArray[math.random(1, #charArray)]
      end
    end

    -- Print out array.
    monitor.clear()
    for x = 1, monitorX do
      for y = 1, monitorY do
        if (y < (midY - 2) or y > (midY + 2)) or (x < (midX - 2) or x > (midX + msgLen + 2)) then
          monitor.setCursorPos(x, y)
          monitor.setTextColor(colorArray[math.random(1, #colorArray)])
          monitor.write(array[x][y])
        end
      end
    end

    -- Print CyberCrib team logo.
    monitor.setCursorPos(midX + 1, midY)
    monitor.setTextColor(colors.lime)
    monitor.write(msg)

    -- Shift array down by one y coordinate.
    for x = 1, monitorX do
      for y = monitorY, 1, -1 do
        if y == monitorY then
          array[x][y] = ' '
        else
          array[x][y] = array[x][y - 1]
        end
      end
    end

    -- Regulate how fast it goes.
    -- A value that is too low might lag server.
    -- Use responsibly.
    os.sleep(1)
  end
  os.sleep(2)
end
