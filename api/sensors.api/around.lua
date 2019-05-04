function scanAroundPeripherals(validChestList)
    print("Peripherals attached...")
    plist = peripheral.getNames()
    for i = 1, #plist do
        peripheralType = peripheral.getType(plist[i])
        print(" ", plist[i], " type: ", peripheralType)
    end
end

scanAroundPeripherals()