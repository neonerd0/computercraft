local tArgs = {...}
if #tArgs ~= 2 then
  print("Requires length, width")
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

if not move.hasEnoughFuel(x, y, 0) then
    print("Not enough fuel for floor size")
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
turtle.forward()
local b = move.rectMotionDoWhile(x, y, tryPlaceAnyDown)
if b then
    print("Success!")
else
    print("Failure!")
end

print("Fuel remaining:")
print(turtle.getFuelLevel());