os.loadAPI("transformation")

function lineMotionDoWhile(t, x, func)
    for xI = 0, x do
        --- Do action
        local b = func()

        --- Action failed
        if not b then
            print("func failed!")
            return b
        end

        --- Move forward
        transformation.forward(t)
        
        --- Cannot move forward
        if t.ret == false then
            return t.ret
        end
    end
    return true
end


function rectMotionDoWhile(transform, x, z, func)

    print("rectMotionDoWhile!")
    local turnRight = transformation.turnRight
    local turnLeft = transformation.turnLeft

    local turn = turnRight

    for xI = 0, x do
        print(xI)
        if lineMotionDoWhile(transform, z, func) == false then
            print("Line motion failed!")
            return false
        end

        if xI % 2 == 0 then
            turn = turnRight
        else
            turn = turnLeft
        end

        turn(transform)
        if func() == false then
            print("func() failed!")
            return false
        end
        transformation.forward(transform)
        turn(transform)
    end

    return true
end