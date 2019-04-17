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