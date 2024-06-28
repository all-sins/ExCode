-- TODO:
-- 1) Turtle returns nil forever on line 18 probably if there is no block under on start.
-- 2) Fuel check?
-- 3) Inventory unload malfunctions when returning on line 117.

-- Last run results. Finished one block higher than start.
-- FINDING1: Works fine if it mines and moves the last block.
-- Start: 0
-- Currently: 0
-- Lowerst point: -61

-- Figure out how to traverse 3D cube.
-- X -
-- X 0
-- X +

-- - 0 +
-- Z Z Z

-- Change.
iterations = 1

-- Do not change.
yPosMin = 0
xPos = 0
yPos = 0
zPos = 0
TARGET_FUEL_LEVEL = 512
FUEL_ITEM_LIST = {"minecraft:coal", "minecraft:charcoal"}
BEDROCK = "minecraft:bedrock"
blockBellow = "placeholder"
-- BEDROCK = "minecraft:cobblestone"

function contains(list, str)
    for _, v in ipairs(list) do
        if v == str then
            return true
        end
    end
    return false
end

-- Define methods.
function invHasSpace()
   for i = 1, 16 do
      if (turtle.getItemCount(i) == 0) then
         return true
      end
   end
   return false
end

function surface() 
   while (yPos ~= 0) do
      turtle.up()
      yPos = yPos + 1
      print(yPos)
   end
end

function descend(targetY)
   while (yPos ~= targetY) do
      turtle.down()
      yPos = yPos - 1
      print(yPos)
   end
end

function unload()
   for i = 1, 16 do
      turtle.select(i)
      turtle.drop()
   end
   turtle.select(1)
end

function surfaceUnloadDescend(currentY)
   surface()
   unload()
   descend(currentY)
end

function refuelCoal() {
   for i = 1, 16 do
      turtle.select(i)
      if (turtle.getItemDetail().name == "minecraft:coal") {
         while (turtle.getFuelLevel() < targetFuelLevel) {
            turtle.refuel(1)
         }
      }
   end
   
   NO_MORE_FUEL = false
   while (not NO_MORE_FUEL) do
      for i = 1, 16 do
         turtle.select(i)
         if (turtle.getItemDetail().name == "minecraft:coal") then
            while (turtle.getFuelLevel() < targetFuelLevel) do
               turtle.refuel(1)
            end
         end
      end
   end
   
   print("[REFUEL] Starting: ", turtle.getFuelLevel())
   local INVENTORY_SCANNED = false
   while (turtle.getFuelLevel() < TARGET_FUEL_LEVEL or INVENTORY_SCANNED) then
      for i = 1, 16 do
         local itemCount = turtle.getItemCount()
         if (itemCount ~= 0) then
            if (contains(FUEL_ITEM_LIST, turtle.getItemDetail().name)) then
               while (turtle.getFuelLevel() < TARGET_FUEL_LEVEL or itemCount ~= 0) then
            end
         end
      end
   end
   print("[REFUEL] Ending: ", turtle.getFuelLevel())
}

for i = 1, iterations do
   print("Running iteration ", i)

   while (blockBellow ~= BEDROCK) do
      print(blockBellow)
      
      -- Deposit inventory if full.
      if (not invHasSpace()) then
         print("")
         surfaceUnloadDescend(yPos)
      end
   
      -- Inspect block bellow.
      success, data = turtle.inspectDown()
      blockBellow = data.name
      
      -- Mine it if it exists.
      if (blockBellow ~= BEDROCK) then
         if (success) then
            print("Dig!")
            turtle.digDown()
            
            print("Collect!")
            turtle.suckDown()
            
            print("Move!")
            turtle.down()
         else
            turtle.down()
         end
         yPos = yPos - 1
      end
      print(yPos)
      
   end
   
   -- Debug
   yPosMin = yPos
  
   surface()
   unload()
   
   -- Debug
   print("Start:", 0)
   print("Currently:", yPos)
   print("Lowest point:", yPosMin)
   
end