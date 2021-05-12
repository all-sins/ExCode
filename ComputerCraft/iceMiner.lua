-- INIT
print( "[INIT] Checking for fuel on slot 15..." )
legalItems = {"minecraft:coal", "minecraft:charcoal"}
turtle.select(16)
if turtle.getItemCount(16) ~= 0 then
	slotInfo = turtle.getItemDetail()
	validType = false
	for i = 1, 2 do
			if legalItems[i] == slotInfo.name then
				validType = true
			end
		end
	if validType then
		print( "[INIT] Coal found! Refueling!" )
		turtle.refuel()
	else
		print( "[INIT] No fuel found!" )
	end	
else
	print("[INIT] No items in slot 15. Skipping refueling!")
end
turtle.select(1)

if turtle.getFuelLevel() < 1 then
		print("[ERROR] Not enough fuel. Exiting!")
		return
end

-- MAIN
print( "Use WASD to move around. Q and E to go up and down." )
while true do

  -- Listener for key event.
  local event, key = os.pullEvent("key")
  
  if key == keys.w then
	print("[EVENT] W")
  	if turtle.detect() then
		turtle.dig()
		turtle.suck()
		turtle.select(13)
		turtle.place()
		turtle.dig()
		turtle.suck()
		turtle.select(1)
	end
	turtle.forward()
  elseif key == keys.s then
	print("[EVENT] S")
  	turtle.back()
  elseif key == keys.a then
	print("[EVENT] A")
  	turtle.turnLeft()
  elseif key == keys.d then
	print("[EVENT] D")
  	turtle.turnRight()
  elseif key == keys.q then
	print("[EVENT] Q")
  	turtle.up()
  elseif key == keys.e then
	print("[EVENT] E")
  	turtle.down()
  end
  
end