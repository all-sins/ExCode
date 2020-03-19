--Variable decleration
local dimX, dimY
--Main Quarry Loop variables
local turnedRight, goingUp
local posX, posY, a, b, main, invSpace, invFullCount, moveCount, turnCount, mineCount, status

--Variable initialization
turnedRight = false
goingUp = true
a = 0
b = 0
main = 0
invSpace = 0
invFullCount = 0
moveCount = 0
turnCount = 0
mineCount = 0
status = 0

--Functions
--Returns name of block at the specified direction
--If there is no block then returns false
function getBlockName(direction)
    upSuccess, upData = turtle.inspectUp()
    frontSuccess, frontData = turtle.inspect()
    downSuccess, downData = turtle.inspectDown()
	
    if direction == "up" then
        if upSuccess == false then
            print("No block above!")
			return false
		else
    return upData.name
  end
	elseif direction == "forward" then
		if forwardSuccess == false then
			print("No block in front!")
			return false
		else
    return forwardData.name
  end
	elseif direction == "down" then
		if downSuccess == false then
			print("No block below!")
			return false
        else
            return downData.name
        end
	else
        print("Invalid syntax!")
        print("Valid paramaters are up, front and down.")
    end
end

function isInvFull()
	for i=1, 16 do
		if turtle.getItemCount(i) == 0 then
			return false
		end
	end
	return true
end

function printDebug()
	term.clear()
	term.setCursorPos(1,1)
	print("Inventory full: ", isInvFull())
	print("Status: ", status)
end

--Get Quarry dimensions from user
print("Please enter dimensions of the Quarry.")
print("X?")
dimX = io.read()
print("Y?")
dimY = io.read()

--Main Quarry loop
--Loop forward and back
for main=0,1 do
	printDebug()
	for a=0,2+1 do
		printDebug()
		--Mine straight 3 times
		for b=0,2 do
			printDebug()
			if turtle.detect() then
				turtle.dig()
				turtle.suck()
			end
			turtle.forward()
		end
		--bFor end
		
		if a<=2 then
			if turnedRight == false then
				turnedRight = true
				turtle.turnRight()
				
				if turtle.detect() then
					turtle.dig()
					turtle.suck()
				end
				turtle.forward()
				turtle.turnRight()
				--Finished turning around
				--Going down
				goingUp = false
			else
				turnedRight = false
				turtle.turnLeft()
				
				if turtle.detect() then
					turtle.dig()
					turtle.suck()
				end
				turtle.forward()
				turtle.turnLeft()
				--Going up
				goingUp = true
			end
		else
			--Last lap no turning at the end of the staright mining
			--Turned right
			for b=0,2 do
    printDebug()
				if turtle.detect() then
					turtle.dig()
					turtle.suck()
				end
				turtle.forward()
			end
			turtle.turnRight()
			turtle.turnRight()
			if getBlockName(down) == "minecraft:bedrock" then
				print("Bedrock detected! Returning home!")
				--path back dump items and end
				--TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO
				io.read()
				os.exit()
			end
			turtle.digDown()
			turtle.down()
		end
	end
	--aFor end
	
	--Toggle turned right for going backwards
	if turnedRight == true then
		turnedRight = false
	else
		turnRight = true
	end
end