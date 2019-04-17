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
  return true
end

function digClearUp()
  blocked, data = turtle.inspectUp()
  while blocked do
    turtle.digUp()
    blocked, data = turtle.inspectUp()
  end
  return true
end

y = y - 1
x = x - 1

turnLeft = transformation.turnLeft
turnRight = transformation.turnRight

for yI = 0, y do

  -- if yI % 2 == 0 then
  --   turnLeft = transformation.turnLeft
  --   turnRight = transformation.turnRight
  -- else
  --   turnLeft = transformation.turnRight
  --   turnRight = transformation.turnLeft
  -- end

  for zI = 0, z do

    turn = turnLeft
    if zI % 2 == 0 then
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

  digClearUp()

  if yI < y then
    transformation.up(t)
  end
  transformation.turnAround(t)

end

transformation.gotoPosition(t, vector.makeZero())
