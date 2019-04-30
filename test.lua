function getSlot(chest, i)
    return chest.getStackInSlot(i)
end

function getName(chest, i)
    local slot = getSlot(chest, i)
    if slot then
        return slot.name
    else
        return false
    end
end

function getID(chest, i)
    local slot = getSlot(chest, i)
    if slot then
        return slot.id
    else
        return false
    end
end

function getDamage(chest, i)
    local slot = getSlot(chest, i)
    if slot then
        return slot.dmg
    else
        return false
    end
end

function getQty(chest, i)
    local slot = getSlot(chest, i)
    if slot then
        return slot.qty
    else
        return false
    end
end

function inspectSlot(chest, i)
    name = getName(chest, i)
    if name == false then
        --print("no item in slot: ", i)
    else
        sprint(name)
        sprint(getID(chest, i))
        sprint(getDamage(chest, i))
        sprint(getQty(chest, i))
    end
end

function sprint(s)
    if s == false then
        return
    else
        print(s)
    end
end

print("Peripherals attached...")
plist = peripheral.getNames()
for i = 1, #plist do
    print(" ", plist[i], " type: ", peripheral.getType(plist[i]))
end

rchest = peripheral.wrap("right")

if rchest == nil then
    print("No chest on right")
else
    rmax = rchest.getInventorySize()
    print("Right chest contents...")
    for i = 1, rmax do
        inspectSlot(rchest, i)
    end
end

lchest = peripheral.wrap("left")
if lchest == nil then
    print("No chest on left")
else
    lmax = lchest.getInventorySize()
    print("Left chest contents...")
    for i = 1, lmax do
        inspectSlot(lchest, i)
    end
end
