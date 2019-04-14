os.loadAPI("transformation")
t = transformation.newTransform()


function lineMotionDoWhile(x, func)
    for xI = 1, x do
        --- Do action
        local b = func()

        --- Action failed
        if not b then
            print("func failed!")
            return b
        end

        --- Dont move forward if last iteration
        if xI == x then
            return true
        end

        --- Move forward
        t = transformation.forward(t)
        
        --- Cannot move forward
        if t.ret == false then
            return t.ret
        end
    end
    return true
end


function dig()
    turtle.dig()
    return true
end


function test1()
    lineMotionDoWhile(10, dig)
    turtle.digUp()
    t = transformation.up(t)
    t = transformation.turnAround(t)
    lineMotionDoWhile(10, dig)
end

function test2()
    print("Starting..")
    sleep(1)

    print("Facing positive X-axis")
    t = rotational.faceAxis(t, vector.make(1, 0, 0))
    sleep(1.0)
    print("Facing negative X-axis")
    t = rotational.faceAxis(t, vector.make(-1, 0, 0))
    sleep(1.0)

    print("Facing positive z-axis")
    t = rotational.faceAxis(t, vector.make(0, 0, 1))
    sleep(1.0)
    print("Facing negative z-axis")
    t = rotational.faceAxis(t, vector.make(0, 0, -1))
    sleep(1.0)
end


function test3()
    t = transformation.gotoPosition(t, vector.make(1, 2, -3))
end



test3()