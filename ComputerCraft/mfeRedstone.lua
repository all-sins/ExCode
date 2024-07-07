redstoneInputFace = "front"
redstoneOutputFace = "left"
coalBurnTime = 20

redstone.setAnalogOutput(redstoneOutputFace, 15)

while true do
  if (redstone.getAnalogInput(redstoneInputFace) == 0) then
    print("MFE is low. Charging...")
    redstone.setAnalogOutput(redstoneOutputFace, 0)
    sleep(coalBurnTime - 1)
    redstone.setAnalogOutput(redstoneOutputFace, 15)
  else
    print("MFE has energy.")
    sleep(5)
  end
  sleep(3)
end

