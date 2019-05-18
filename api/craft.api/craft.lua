os.loadAPI("chests")
os.loadAPI("inspectchest")
os.loadAPI("dump")
validChests = chests.loadValidChests()
chestList = chests.getAdjChests(validChests)

inputChest = peripheral.wrap("top")

loadedRecipes = {}

gQty = 0

function learnNewCraft()
    local recipe = {}
    getCurrentRecipe(recipe)
    turtle.select(1)
    b = turtle.craft()
    if b == true then
        print("Success!")
        print("New recipe learnt:")
        sleep(0.6)
        d = turtle.getItemDetail()
        recipe.name = d.name
        recipe.damage = d.damage
        printRecipe(recipe)
        saveNewRecipe(recipe)
    else
        print("invalid items")
    end
end


function learnNewCraftWithHint(hint)
    local recipe = {}
    getCurrentRecipe(recipe)
    turtle.select(1)
    b = turtle.craft()
    if b == true then
        print("Success!")
        print("New recipe learnt:")
        sleep(0.6)
        d = turtle.getItemDetail()
        recipe.name = d.name
        recipe.damage = d.damage
        recipe["hint"] = hint
        printRecipe(recipe)
        saveNewRecipe(recipe)
    else
        print("invalid items")
    end
end


function saveNewRecipe(recipe)
    local file = fs.open("recipes.txt", "a")
    h = {}
    t = {}
    h[#h+1] = tostring(recipe.name)
    h[#h+1] = tostring(recipe.damage)
    h[#h+1] = tostring(recipe.hint)
    for i = 1, 16 do
        if recipe.slot[i] ~= nil then
            t[#t+1] = tostring(i)
            t[#t+1] = tostring(recipe.slot[i].name) 
            t[#t+1] = tostring(recipe.slot[i].damage)
        end
    end
    s = table.concat(h, " ")
    file.write(s .. "\n")
    s = table.concat(t, " ")
    file.write(s .. "\n")
    file.close()
end


function loadAllRecipes()
    print("Loading all recipes in recipes.txt...")
    local file = fs.open("recipes.txt", "r")
    local fileData = {}
    line = nil
    repeat
        line = file.readLine()
        if line ~= nil then
            fileData[#fileData+1] = line
        end
    until line == nil
    file.close()
    print("Loaded ", #fileData, " line of data")

    local loadedRecipes = {}
    h = ""
    b = ""
    for i = 1, #fileData do
        segment = i % 2
        if segment == 1 then
            h = fileData[i]
        else
            b = fileData[i]
            r = loadRecipe(h, b)
            uid = r.name .. tostring(r.damage)
            print("new uid: ", uid)
            loadedRecipes[uid] = r
        end
    end

    return loadedRecipes
end


function printAllKnownRecipes()

    local count = 0
    for k, v in pairs(loadedRecipes) do
        print(count, ": ", k)
        printRecipe(v)
        count = count + 1
    end

    if count == 0 then
        print("No known recipes")
    end
end


function loadRecipe(header, body)
    local r = {}
    r["slot"] = {}

    --- Load header
    i = 0
    for w in header:gmatch("%S+") do
        if i == 0 then
            r["name"] = w
        elseif i == 1 then
            r["damage"] = tonumber(w)
        elseif i == 2 then
            r["hint"] = w
        end
        i = i + 1
    end

    --- Load body
    i = 0
    --currentSlot = {}
    slotIdx = 0
    for w in body:gmatch("%S+") do
        slotStep = i % 3
        if slotStep == 0 then
            slotIdx = tonumber(w)
            r.slot[slotIdx] = {}
        elseif slotStep == 1 then
            r.slot[slotIdx]["name"] = w
        elseif slotStep == 2 then
            r.slot[slotIdx]["damage"] = tonumber(w)
        end
        i = i + 1
    end

    return r
end


function printRecipe(r)
    print(r.name, ", ", r.damage)
    print(r.hint)
    for i = 1, 16 do
        if r[i] ~= nil then
            print("slot: ", i, ", ", r.slot[i].name, ", ", r[i].slot.damage)
        end
    end
end


function getCurrentRecipe(recipe)
    recipe["name"] = ""
    recipe["damage"] = nil
    recipe["slot"] = {}
    recipe["hint"] = "-"
    for i = 1, 16 do
        itemDetails = turtle.getItemDetail(i)
        if itemDetails then
            recipe.slot[i] = {}
            recipe.slot[i]["name"] = itemDetails.name
            recipe.slot[i]["damage"] = itemDetails.damage
        end
    end
end


function getUniqueID(slot)
    return tostring(slot.name) .. tostring(slot.damage)
end


function oppositeDirectionStr(dir)
    if dir == "left" then
        return "EAST"
    elseif dir == "right" then
        return "WEST"
    elseif dir == "top" then
        return "DOWN"
    elseif dir == "bottom" then
        return "UP"
    elseif dir == "front" then
        return "SOUTH"
    elseif dir == "back" then
        return "NORTH"
    end
end


function fetchItemFromChest(itemName, itemDamage, turtleSlot, qty)

    for k, vchest in pairs(chestList) do
        i = inspectchest.getSlotWithItem(vchest, itemName, itemDamage)
        if i ~= nil then
            dir = oppositeDirectionStr(k)
            b = vchest.pushItem(dir, i, qty, turtleSlot)
            print(b, "/", qty)
            if b == nil then
                return false
            elseif b < qty then
                qty = qty - b
            else
                return true
            end
        end
    end

    return qty <= 0
end


function isRecoginizedRecipe(uniqueID)
    return loadedRecipes[uniqueID] ~= nil
end


--- Search nearby chests for ingredients and place
--- them into the appropiate slots in the turtles 
--- inventory
function tryCraft(recipe, qty)
    for i = 1, 16 do
        if recipe.slot[i] ~= nil then

            local uid = getUniqueID(recipe.slot[i])
            print("We need: ", uid)
            local b = fetchItemFromChest(recipe.slot[i].name, recipe.slot[i].damage, i, qty)

            --- fail to get item from chest, try to make one
            if b == false then
                b = isRecoginizedRecipe(uid)
                if b == true then
                    dump.dump_all_up()
                    if tryCraft(loadedRecipes[uid], qty) == false then
                        return false
                    end
                    if tryCraft(recipe, qty) == true then
                        return true
                    else
                        return false
                    end
                    --fetchItemFromChest(recipe.slot[i].name, recipe.slot[i].damage, i, 1)
                else
                    print("No ingredients to make or ingredients are not recognized as a recipe!")
                    return false
                end
            --- Got an item from the chest!
            else
            end
        end
    end
    turtle.craft()
    dump.dump_all_up()
    return true
end


function tryCraftLoop(recipe, totalQty)
    gQty = totalQty
    repeat
        print(gQty, " items left to craft...")
        currQty = math.min(gQty, 64)
        b = tryCraft(recipe, currQty)
        gQty = gQty - currQty
    until b == false or gQty <= 0
    if b == false then
        print("Failed to craft items!")
    end
    if gQty <= 0 then
        print("Finished crafting target quantity!")
    end
    return b
end


function tryCraftWithHint(hint, qty)
    loadedRecipes = loadAllRecipes()
    gQty = qty;
    for k, v in pairs(loadedRecipes) do
        if v.hint == hint then
            b = tryCraftLoop(loadedRecipes[k], gQty)
            return b
        end
    end

    --- the hint might be a UID 
    if isRecoginizedRecipe(hint) then
        b = tryCraftLoop(loadedRecipes[hint], gQty)
        return b
    end
end


function usage()
    print("USAGE:")
    print("   craft <command> <parameters>")
    print("COMMANDS:")
    print("   new, list, make <# of items>, help <command>")
    print("")
    print("   You can display detailed help for each command")
    print("   e.g. craft help make")
end


local args = {...}

if #args == 1 then
    if args[1] == "new" then
        learnNewCraft()
    elseif args[1] == "list" then
        loadedRecipes = loadAllRecipes()
        printAllKnownRecipes()
    else
        usage()
    end
elseif #args == 2 then
    if args[1] == "new" then
        local hint = args[2]
        learnNewCraftWithHint(hint)
    else
        usage()
    end
elseif #args == 3 then
    if args[1] == "make" then
        local target = args[2]
        local qty = tonumber(args[3])
        if qty < 1 then
            qty = 1
        end
        tryCraftWithHint(target, qty)
    end
else
    usage()
end