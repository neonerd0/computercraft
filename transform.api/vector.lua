function makeZero()
    local v = {}
    v['x'] = 0
    v['y'] = 0
    v['z'] = 0
    return v
end

function make(x, y, z)
    local v = makeZero()
    v.x = x
    v.y = y
    v.z = z
    return v
end

function scale(lhs, coeff)
    local d = makeZero()
    d.x = lhs.x * coeff
    d.y = lhs.y * coeff
    d.z = lhs.z * coeff
    return d
end

function add(lhs, rhs)
    local d = makeZero()
    d.x = lhs.x + rhs.x
    d.y = lhs.y + rhs.y
    d.z = lhs.z + rhs.z
    return d
end

function sub(lhs, rhs)
    local d = makeZero()
    d = add(lhs, scale(rhs, -1))
    return d
end

function distance(lhs, rhs)
    return sub(lhs, rhs)
end

function toString(v)
    return v.x .. "," .. v.y .. "," .. v.z
end

function equalDirection(lhs, rhs)
    return lhs.x == rhs.x and lhs.y == rhs.y and lhs.z == rhs.z
end