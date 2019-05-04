
sensor = peripheral.wrap("right") ---Sensor always to be placed on the right side of the turtle

attackState = false

function gotoAttackState()
    if attackState then
        turtle.attack()
        return
    else
        attackState = true
        turtle.down()
    end
end

function gotoGuardState()
    if attackState then
        attackState = false;
        turtle.up()
    else
        return
    end
end

while true do
    sleep(0.2)
    mobs = sensor.getEntityIds("mob")
    if #mobs == 0 then
        print("No mobs around me!")
        gotoGuardState()
    else
        print("Mob!")
        gotoAttackState()
    end
end