monitor = peripheral.wrap("left")
monitor.clear()
time = 10
logCount = 0
logMsg = "Placed:"
scaleSleep = 2
noItems = false
isBlock = false
while true do
  if (turtle.getItemCount() == 0) then
    turtle.suckUp()
  end
  if (turtle.getItemCount() ~= 0) then
    noItems = false
    isBlock = turtle.detectDown()
    if (not isBlock) then
      turtle.placeDown()
      logCount = logCount + 1
      monitor.clear()
      monitor.setCursorPos(1, 1)
      monitor.write(logMsg)
      monitor.setCursorPos(1, 2)
      monitor.write(logCount)
      scaleSleep = 2
    end
  else
    noItems = true
  end
  if (noItems or (not isBlock)) then
    scaleSleep = scaleSleep + 2
  end
  sleep(scaleSleep)
end
