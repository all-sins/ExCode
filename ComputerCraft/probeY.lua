turtle.refuel()
startY = 63
depth = 0
while ( turtle.down() ) do
  depth = depth + 1
end
print("Bottom @ "..startY - depth)
while ( depth > 0 ) do
  if ( turtle.up() ) then
    depth = depth - 1
  else
    os.sleep(2)
  end
end