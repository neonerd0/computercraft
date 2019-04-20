os.loadAPI("rotational")


function newTransform()
    local transform = {}
    transform['position'] = vector.makeZero()
    transform['forward'] = vector.make(0, 0, 1)
    transform['rotation'] = 0
    transform['ret'] = true --For error checking
    return transform
end


function clamp(value, low, high)
    return math.max(math.min(value, high), low)
end


function gotoPosition(transform, target)

    --print("Moving to position: ", vector.toString(target))

    local p = transform.position
    local d = vector.sub(target, p)

    --print("movement vec: ", vector.toString(d))

    x_axis = vector.make(clamp(d.x, -1, 1), 0, 0)
    z_axis = vector.make(0, 0, clamp(d.z, -1, 1))
    y_axis = vector.make(0, clamp(d.y, -1, 1), 0)

    print("facing x-axis")
    rotational.faceAxis(transform, x_axis)
    print("moving in x-axis")
    for i = 1, math.abs(d.x) do
        forward(transform)
        if transform.ret == false then
            print("Error moving forward!")
            return false
        end
    end

    print("facing z-axis")
    rotational.faceAxis(transform, z_axis)
    print("moving in z-axis")
    for i = 1, math.abs(d.z) do
        forward(transform)
        if transform.ret == false then
            print("Error moving forward!")
            return false
        end
    end

    motion = nil
    print("moving in y-axis")
    if d.y > 0 then --Move up
        motion = up
    elseif d.y < 0 then --Move down
        motion = down
    end

    if motion ~= nil then
        for i = 1, math.abs(d.y) do
            motion(transform)
            if transform.ret == false then
                print("Error moving vertically!")
                return false
            end
        end
    end

    transform.ret = true
    return true
end


function forward(currentTransform)
    local p = currentTransform.position
    local f = currentTransform.forward

    --- Try to move forward
    local b = turtle.forward()
    currentTransform.ret = b

    --- Error
    if not b then
        return b
    end

    --- Update position
    p = vector.add(p, f)
    currentTransform.position = p
    return b
end


function up(currentTransform)
    local p = currentTransform.position

    --- Try to move upwards
    local b = turtle.up()
    currentTransform.ret = b
    if not b then
        return b
    end

    --- Update position
    p = vector.add(p, vector.make(0, 1, 0))
    currentTransform.position = p
    return b
end


function down(currentTransform)
    local p = currentTransform.position

    --- Try to move downwards
    local b = turtle.down()
    currentTransform.ret = b
    if not b then
        return b
    end

    --- Update position
    p = vector.add(p, vector.make(0, -1, 0))
    currentTransform.position = p
    return b
end


function back(currentTransform)
    local p = currentTransform.position
    local f = currentTransform.forward

    --- Try to move backwards
    local b = turtle.back()
    currentTransform.ret = b
    if not b then
        return b
    end

    --- Update position
    p = vector.sub(p, f)
    currentTransform.position = p
    return b
end


function turnRight(currentTransform)
    return rotational.turnRight(currentTransform)
end


function turnLeft(currentTransform)
    return rotational.turnLeft(currentTransform)
end


function turnAround(currentTransform)
    return rotational.turnAround(currentTransform)
end

function face(transform, axis)
    rotational.faceAxis(transform, axis)
end