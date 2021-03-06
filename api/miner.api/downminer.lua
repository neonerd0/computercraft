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


os.loadAPI("dump")
os.loadAPI("transformation")
os.loadAPI("scanbranchminer")
os.loadAPI("stack")
os.loadAPI("inventory")

t = transformation.newTransform()
position_stack = stack.newStack()
forward_stack = stack.newStack()
worthy_ores = scanbranchminer.loadWorthyOres()

worthless_ore = "minecraft:cobblestone"


function select_worthless()
  --inventory.sort()
  for i = 1, 16 do
    d = turtle.getItemDetail(i)
    if d ~= nil and d.name == worthless_ore then
      turtle.select(i)
      return
    end
  end
end


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
    scanbranchminer.scanAllStart(t, position_stack, forward_stack, worthy_ores)
  end
  while t.position.y < 0 do
    turtle.digUp()
    transformation.up(t)
  end
end


function deposit()
  transformation.gotoPosition(t, vector.makeZero())
  transformation.face(t, vector.make(0,0,-1))
  dump_loot()
end


function dump_loot()
  --- Dump all but 1 worthless item
  for i = 1, 16 do
      turtle.select(i)
      d = turtle.getItemDetail(i)
      if d then
        if d.name == worthless_ore then
          turtle.drop(d.count - 1)
        else
          turtle.drop()
        end
      end
  end
end


function run()
  x = x - 1
  z = z - 1
  for xI = 0, x do
    for zI = 0, z do
      --- Move to the XZ coordinate
      _x = xI * 3
      _z = zI * 3
      local v = vector.make(_x, 0, _z)
      transformation.gotoPosition(t, v)

      --- Place marker above
      select_worthless()
      turtle.placeUp()

      --- Dig a hole
      dig_col()

      --- Return to the surface
      topX = t.position.x
      topZ = t.position.z
      topV = vector.make(topX, 0, topZ)
      transformation.gotoPosition(t, topV)

      --- Cover the hole
      select_worthless()
      turtle.placeDown()

      --- Deposite ores
      deposit()
    end
  end
  deposit()
end

run()