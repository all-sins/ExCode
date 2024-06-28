local monitor = peripheral.wrap("bottom")
local monitorX, monitorY = monitor.getSize()
local array = {}
local charArray = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'}
debug = false
monitor.clear()

--Init array
for x = 1, monitorX do
  array[x] = {}
  for y = 1, monitorY do
    array[x][y] = ' '
  end
end

--Logo print calculations.
msg = "CyberCrib"
msgLen = string.len(msg)
if (monitorX % 2 == 0) then
  midX = (monitorX / 2) - (msgLen / 2)
else
  midX = (monitorX / 2) - ((msgLen / 2) - 1)
end
midY = monitorY / 2

while true do
  while redstone.getInput("right") do
    --Fill first row of array with random chars
    for i = 1, #array do
      if math.random(1, 10) == 1 then
        array[i][1] = charArray[math.random(1, #charArray)]
      end
    end

    --Print out array
    monitor.clear()
    local colorArray = {colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow, colors.lime, colors.pink, colors.gray, colors.lightGray, colors.cyan, colors.purple, colors.blue, colors.brown, colors.green, colors.red}
    for x = 1, monitorX do
      for y = 1, monitorY do

        --debug
        if (debug) then
          monitor.setCursorPos(1, 1)
          monitor.write("midX:"..midX)
          monitor.setCursorPos(1, 2)
          monitor.write("midY:"..midY)
          monitor.setCursorPos(1, 3)
          monitor.write("monitorX:"..monitorX)
          monitor.setCursorPos(1, 4)
          monitor.write("monitorY:"..monitorY)
        end

        if ( (y < (midY - 3) or y > (midY + 2)) or (x < (midX - 2) or x > (midX + msgLen + 1)) ) then
          monitor.setCursorPos(x, y)
          monitor.setTextColor(colorArray[math.random(1, 15)])
          monitor.write(array[x][y])
        end
        --os.sleep(0.1)
      end
      --os.sleep(0.1)
    end

    --Print CyberCrib team logo.
    monitor.setCursorPos(midX, midY)
    monitor.setTextColor(colors.lime)
    monitor.write(msg)

    --Shift array down by one y coordinate
    for x = 1, monitorX do
      for y = monitorY, 1, -1 do
        if y == monitorY then
          array[x][y] = ' '
        else
          array[x][y] = array[x][y-1]
        end
      end
    end

    --Regulate how fast it goes
    os.sleep(1)
  end
  os.sleep(2)
end
