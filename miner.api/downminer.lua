local tArgs = {...}
if #tArgs ~= 2 then
  print("Requires length, width")
  return
end
 
local x = tonumber(tArgs[1])
local z = tonumber(tArgs[2])
 
if x == nil or z == nil then
  print("Invalid dimensions")
  return
end
 
if x < 0 or z < 0 then
  print("Invalid (negative) dimensions")
  return
end
 
local fuel = turtle.getFuelLevel()
local roomSize = x * z * 100
while fuel < roomSize do
  if not turtle.refuel(1) then
    print("Not enough fuel")
    return
  end
end


os.loadAPI("transformation")
t = transformation.newTransform()


function try_dig()
  --- compare with blacklist ore
  for i = 1, 4 do
      turtle.select(i)
      if turtle.compare() then
          return false
      end
  end
  turtle.dig()
  return true
end


function crosswise_check()
  try_dig()
  for i = 1, 3 do
      transformation.turnLeft(t)
      try_dig()
  end
end


function move_down()
  turtle.digDown()
  return transformation.down(t)
end


function dig_col()
  while move_down() do
    crosswise_check()
  end
  while t.position.y < 0 do
    turtle.digUp()
    transformation.up(t)
  end
end


function run()
  x = x - 1
  z = z - 1
  for xI = 0, x do
    for zI = 0, z do
      topX = t.position.x
      topZ = t.position.z
      topV = vector.make(topX, 0, topZ)
      transformation.gotoPosition(t, topV)
      turtle.select(1)
      turtle.placeDown()

      _x = xI * 3
      _z = zI * 3
      local v = vector.make(_x, 0, _z)
      transformation.gotoPosition(t, v)

      dig_col()
    end
  end
end

run()