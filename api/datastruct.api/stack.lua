function newStack()
    local _stack = {}
    _stack['count'] = 0
    return _stack
end

function push(_stack, value)
    _stack.count = _stack.count + 1
    _stack[_stack.count] = value
end

function pop(_stack)
    local value = _stack[_stack.count]
    _stack.count = _stack.count - 1
    return value 
end

function size(_stack)
    return _stack.count
end