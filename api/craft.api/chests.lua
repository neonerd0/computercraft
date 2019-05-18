function loadValidChests()
    local file = fs.open("chest_string_type", "r")
    local fileData = {}
    line = nil
    repeat
        line = file.readLine()
        if line ~= nil then
            fileData[line] = true
        end
    until line == nil
    file.close()
    return fileData
end


function isValidChest(chestType, validChestList)
    if validChestList[chestType] ~= nil then
        return true
    else
        return false
    end
end


function getAdjChests(validChestList)
    local c = {}
    print("Peripherals attached...")
    plist = peripheral.getNames()
    for i = 1, #plist do
        peripheralType = peripheral.getType(plist[i])
        print(" ", plist[i], " type: ", peripheralType)
        if isValidChest(peripheralType, validChestList) then
            c[plist[i]] = peripheral.wrap(plist[i])
        end
    end
    return c
end