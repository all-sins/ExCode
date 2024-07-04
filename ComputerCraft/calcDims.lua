fuel = turtle.getFuelLevel()
print("y: ?")
y_level = read()
x_z = 0
function calc(fuel, y)
  x_z = math.floor(math.sqrt((fuel / y)))
end
function printCalcs()
  local volume = x_z ^ 2 * y_level
  print(x_z.."x"..y_level.."x"..x_z.." -> "..volume)
end

calc(fuel, y_level)
printCalcs()
