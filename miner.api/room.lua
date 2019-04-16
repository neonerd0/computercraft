os.loadAPI("transformation")
os.loadAPI("move")
t = transformation.newTransform()

local tArgs = {...}
if #tArgs ~= 3 then
  print("Requires length, width, height")
  return
end

local x = tonumber(tArgs[1])
local z = tonumber(tArgs[2])
local y = tonumber(tArgs[3])

if x == nil or z == nil or y == nil then
    print("Invalid dimensions")
    return
  end
   
if x < 0 or z < 0 or y < 0 then
    print("Invalid (negative) dimensions")
    return
end

local fuel = turtle.getFuelLevel()
local roomSize = x * z * y
while fuel < roomSize do
  if not turtle.refuel(1) then
    print("Not enough fuel")
    return
  end
end

os.loadAPI("transformation")
t = transformation.newTransform()

function digClear()
  blocked, data = turtle.inspect()
  while blocked do
    turtle.dig()
    blocked, data = turtle.inspect()
  end
  return blocked
end

y = y - 1
z = z - 1
x = x - 1

for yI = 0, y do
  for zI = 0, z do
    turnZ = zI % 2
    for xI = 0, x do

      

    end
  end
end

transformation.gotoPosition(t, vector.makeZero())
