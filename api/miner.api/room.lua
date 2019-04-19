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
  while turtle.detect() do
    turtle.dig()
  end
  return true
end

function digClearUp()
  while turtle.detectUp() do
    turtle.digUp()
  end
  return true
end

x = x - 1
z = z - 1
y = y - 1

turnLeft = transformation.turnLeft
turnRight = transformation.turnRight

for yI = 0, y do
  for zI = 0, z do
    zy = zI + yI
    turn = turnLeft
    if zy % 2 == 0 then
      turn = turnRight
    end

    move.lineMotionDoWhile(t, x, digClear)

    if zI < z then
      turn(t)
      digClear()
      transformation.forward(t)
      turn(t)
    end

  end

  if yI < y then
    digClearUp()
    transformation.up(t)
  end
  transformation.turnAround(t)

end

transformation.gotoPosition(t, vector.makeZero())
