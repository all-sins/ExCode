local monitor = peripheral.wrap("top")
local monitorX, monitorY = monitor.getSize()
local array = {}
local charArray = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'}
monitor.clear()

function getArrayLength(inputArray)
    local a = 1
    while inputArray[a+1] ~= nil do
        a = a + 1
    end
    return a
end

--Init array
for x = 1, monitorX do
    array[x] = {}
    for y = 1, monitorY do
        array[x][y] = ' '
    end
end

while redstone.getInput("right") do
	--Fill first row of array with random chars
	for i = 1, getArrayLength(array) do
		if math.random(1, 10) == 1 then
			array[i][1] = charArray[math.random(1, getArrayLength(charArray))]  
		end
	end

	--Print out array
	monitor.clear()
	local colorArray = {colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow, colors.lime, colors.pink, colors.gray, colors.lightGray, colors.cyan, colors.purple, colors.blue, colors.brown, colors.green, colors.red}
	for x = 1, monitorX do
		for y = 1, monitorY do
			--term.setCursorPos(x, y)
			--term.write(array[x][y])
			monitor.setCursorPos(x, y)
			term.setTextColor(colorArray[math.random(1, 15)])
			monitor.write(array[x][y])
		end
	end
	
	
	--Shift array down by one y cordinate
	for x = 1, getArrayLength(array) do
		for y = 1, monitorY, 2 do
			if array[x][y+1] ~= nil then
				array[x][y+1] = array[x][y]
				array[x][y] = ' '
			end
		end 
	end
	
	--Regulate how fast it goes
	os.sleep(0.5)
end