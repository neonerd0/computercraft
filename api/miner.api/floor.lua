local tArgs = {...}
if #tArgs ~= 2 then
  print("Requires width, length")
  return
end
 
local x = tonumber(tArgs[1]) - 1
local y = tonumber(tArgs[2])
 
if x == nil or y == nil then
  print("Invalid dimensions")
  return
end
 
if x < 0 or y < 0 then
  print("Invalid (negative) dimensions")
  return
end

--- Load API
os.loadAPI("move")
os.loadAPI("inventory")
os.loadAPI("transformation")

t = transformation.newTransform()

function enoughFuel(width, length) 
  total = width * length
  if total >= turtle.getFuelLevel() then
    print("Not enough fuel for floor size!")
    print(turtle.getFuelLevel(), " level but requires ", total, " fuel!")
    return false
  end
  return true
end

if not enoughFuel(x, y) then
    return
end

--- Place any item below
--- Returns true if successfully places and item below
--- False otherwise
function tryPlaceAnyDown()
    local b = inventory.trySelectAnyFirst()
    if not b then
        print("No items for selection!")
        return false
    end
    sleep(0.01)
    b = turtle.placeDown()
    if not b then
        print("Cannot place down here!")
        return false
    end
    return true
end

--- Build the floor
transformation.forward(t)
local b = move.rectMotionDoWhile(t, x, y, tryPlaceAnyDown)
if b == true then
    print("Success!")
elseif b == false then
    print("Failure!")
else
    print("undefined!")
end

transformation.gotoPosition(t, vector.makeZero())

print("Fuel remaining:")
print(turtle.getFuelLevel());