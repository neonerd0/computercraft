os.loadAPI("transformation")
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