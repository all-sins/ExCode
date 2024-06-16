---@diagnostic disable: lowercase-global
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
ITERATIONS = 1

-- Do not change.
YPOSMIN = 0
XPOS = 0
YPOS = 0
ZPOS = 0
BLOCKBELLOW = "placeholder"
FLAGBLOCK = "minecraft:bedrock"
-- FLAGBLOCK = "minecraft:cobblestone"


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
   while (YPOS ~= 0) do
      turtle.up()
      YPOS = YPOS + 1
      print(YPOS)
   end
end

function descend(targetY)
   while (YPOS ~= targetY) do
      turtle.down()
      YPOS = YPOS - 1
      print(YPOS)
   end
end

function unload()
   for i = 1, 16 do
      turtle.select(i)
      turtle.drop()
   end
   turtle.select(1)
end

function recall()
   surface()
   
end

function surfaceUnloadDescend(currentY)
   surface()
   unload()
   descend(currentY)
end

for i = 1, ITERATIONS do
   print("Running iteration ", i)

   while (BLOCKBELLOW ~= FLAGBLOCK) do
      print(BLOCKBELLOW)
      
      -- Deposit inventory if full.
      if (not invHasSpace()) then
         print("")
         surfaceUnloadDescend(YPOS)
      end
   
      -- Inspect block bellow.
      success, data = turtle.inspectDown()
      BLOCKBELLOW = data.name
      
      -- Mine it if it exists.
      if (BLOCKBELLOW ~= FLAGBLOCK) then
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
         YPOS = YPOS - 1
      end
      print(YPOS)
      
   end
   
   -- Debug
   YPOSMIN = YPOS
  
   surface()
   unload()
   
   -- Debug
   print("Start:", 0)
   print("Currently:", YPOS)
   print("Lowest point:", YPOSMIN)
   
end