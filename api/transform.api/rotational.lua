os.loadAPI('vector')



function turnLeft(currentTransform)
    turtle.turnLeft()
    return updateTurnIndex(currentTransform, -1)
end

function turnRight(currentTransform)
    turtle.turnRight()
    return updateTurnIndex(currentTransform, 1)
end

function turnAround(currentTransform)
    for i = 1, 2 do
        currentTransform = turnLeft(currentTransform)
    end
    return currentTransform
end

function updateTurnIndex(currentTransform, delta)
    local currentTurnIndex = currentTransform.rotation
    currentTurnIndex = currentTurnIndex + delta
    if currentTurnIndex > 2 then
        currentTurnIndex = -1
    elseif currentTurnIndex < -2 then
        currentTurnIndex = 1
    end
    currentTransform.rotation = currentTurnIndex
    currentTransform.forward = rotationIndexToForwardVec(currentTurnIndex)
    return currentTransform
end

function rotationIndexToForwardVec(currentTurnIndex)
    local turnIndexToAxis = {}
    --- Forward
    turnIndexToAxis[0] = vector.make(0, 0, 1)
    --- Left
    turnIndexToAxis[-1] = vector.make(-1, 0, 0)
    --- Right
    turnIndexToAxis[1] = vector.make(1, 0, 0)
    --- Back
    turnIndexToAxis[-2] = vector.make(0, 0, -1)
    turnIndexToAxis[2] = vector.make(0, 0, -1)

    return turnIndexToAxis[currentTurnIndex]
end


function forwardVecToRotationIndex(axis)
    local axisToRotationIndex = {}
    -- Forward
    axisToRotationIndex[vector.make(0,0,1)] = 0
    -- Left
    axisToRotationIndex[vector.make(-1,0,0)] = -1
    -- Right
    axisToRotationIndex[vector.make(1,0,0)] = 1
    -- Back
    axisToRotationIndex[vector.make(0,0,-1)] = 2

    return axisToRotationIndex[axis]
end


function faceAxis(transform, axis)
    --- axis must be unit length
    local len = math.abs(axis.x) + math.abs(axis.z)
    if len ~= 1 then
        print("axis is not well defined!")
        transform.ret = false
        return false
    end

    if axis.y ~= 0 then
        print("Cannot handle face Y axis values, turtle can only turn left/right!")
        transform.ret = false
        return false
    end

    -- To-From lookup table for rotation
    func = {}
    func[0] = nil
    func[-4] = nil
    func[4] = nil
    func[-1] = turnRight
    func[3] = turnRight
    func[-2] = turnAround
    func[2] = turnAround
    func[1] = turnLeft
    func[-3] = turnLeft
    
    d = transform.rotation - forwardVecToRotationIndex(axis)
    turn = func[d]
    if turn ~= nil then
        turn(transform)
    end
    -- while not vector.equalDirection(transform.forward, axis) do
    --     transform = turnLeft(transform)
    -- end

    transform.ret = true
    return true
end