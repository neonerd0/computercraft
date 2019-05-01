function getSlot(c, i)
    return c.getStackInSlot(i)
end


function getName(c, i)
    local slot = getSlot(c, i)
    if slot then
        return slot.name
    else
        return false
    end
end


function getID(c, i)
    local slot = getSlot(c, i)
    if slot then
        return slot.id
    else
        return false
    end
end


function getDamage(c, i)
    local slot = getSlot(c, i)
    if slot then
        return slot.dmg
    else
        return false
    end
end


function getQty(c, i)
    local slot = getSlot(c, i)
    if slot then
        return slot.qty
    else
        return false
    end
end


function inspectSlot(c, i)
    name = getName(c, i)
    if name == false then
        --print("no item in slot: ", i)
    else
        sprint(name)
        sprint(getID(c, i))
        sprint(getDamage(c, i))
        sprint(getQty(c, i))
    end
end


function sprint(s)
    if s == false then
        return
    else
        print(s)
    end
end


function peek(c)
    local max = c.getInventorySize()
    for i = 1, max do
        inspectSlot(c, i)
    end
end


function getSlotWithItem(c, itemName, itemDamage)
    c.condenseItems()
    local max = c.getInventorySize()
    for i = 1, max do
        local slot = getSlot(c, i)
        if slot ~= nil then
            if slot.id == itemName and slot.dmg == itemDamage then
                return i
            end
        end
    end
    return nil
end
