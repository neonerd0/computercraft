
--- Dumps items but leaves 1 item in slots 1-4
function tagged_dump_1234()
    --- Dump all but 1 tagged items (tagged items are in slots 1-4)
    for i = 1, 4 do
        turtle.select(i)
        c = turtle.getItemCount(i)
        if c > 0 then
            turtle.drop(c - 1)
        end
    end

    --- Dump the rest
    for i = 5, 16 do
        turtle.select(i)
        turtle.drop()
    end
end


function dump_all()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
end


function dump_all_up()
    for i = 1, 16 do
        turtle.select(i)
        turtle.dropUp()
    end
end


function dump_all_down()
    for i = 1, 16 do
        turtle.select(i)
        turtle.dropDown()
    end
end