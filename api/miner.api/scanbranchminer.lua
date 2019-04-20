--os.loadAPI("stack")

input_table = {}

function loadWorthyOres()
    local file = fs.open("ore_worthy", "r")
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

function isTargeted(oreName)
    if input_table.targets[oreName] ~= nil then
        return true
    end
    return false
end


function recordLast()
    local p = input_table.t.position
    local f = input_table.t.forward
    stack.push(input_table.sPos, vector.make(p.x, p.y, p.z))
    stack.push(input_table.sFor, vector.make(f.x, f.y, f.z))
end


function getLast()
    local p = stack.pop(input_table.sPos)
    local f = stack.pop(input_table.sFor)
    return p, f
end


function backTrack()
    p, f = getLast()
    digGoto(input_table.t, p)
    transformation.face(input_table.t, f)
end


function digTrace(digFunc, moveFunc)
    recordLast()
    digFunc()
    moveFunc()
end


function forward()
    while turtle.detect() do
        turtle.dig()
    end
    transformation.forward(input_table.t)
end


function up()
    sleep(0.6)
    while turtle.detectUp() do
        sleep(0.6)
        turtle.digUp()
    end
    transformation.up(input_table.t)
end


function down()
    while turtle.detectDown() do
        turtle.digDown()
    end
    transformation.down(input_table.t)
end


--- Dig until the turtle can move
function digGoto(t, pos)
    transformation.gotoPosition(t, pos)
    while t.ret == false do
        --TODO: Find out which direction goto is trying to move
        turtle.dig()
        turtle.digUp()
        turtle.digDown()
        transformation.gotoPosition(t, pos)
    end
end


function scanHorizontal()
    success, data = turtle.inspect()
    if isTargeted(data.name) then
        digTrace(turtle.dig, forward)
        scanAll()
        backTrack()
    end
    for i = 0, 3 do
        success, data = turtle.inspect()
        if isTargeted(data.name) then
            digTrace(turtle.dig, forward)
            scanAll()
            backTrack()
        end
        transformation.turnLeft(input_table.t)
    end
end


function scanVertical()
    success, data = turtle.inspectUp()
    if isTargeted(data.name) then
        digTrace(turtle.digUp, up)
        scanAll()
        backTrack()
    end

    success, data = turtle.inspectDown()
    if isTargeted(data.name) then
        digTrace(turtle.digDown, down)
        scanAll()
        backTrack()
    end
end


function scanAll()
    scanHorizontal()
    scanVertical()
end


function scanAllStart(transform, position_stack, forward_stack, worthy_ores)
    input_table["t"] = transform
    input_table["sPos"] = position_stack
    input_table["sFor"] = forward_stack
    input_table["targets"] = worthy_ores
    scanAll()
end


-- sPos = stack.newStack()
-- sFor = stack.newStack()
-- targets = loadWorthyOres()
-- scanAll()