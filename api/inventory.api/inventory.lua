--- Selects any item in inventory
--- Returns true if an item is selected, false otherwise
function trySelectAnyFirst()
    for i = 1, 16 do
        local c = turtle.getItemCount(i)
        if c >= 1 then
            turtle.select(i)
            print("Selected:")
            print(i)
            return true;
        end
    end 
    print("No items for selection!")
    return false;
end


function sort()
    for i = 1, 16 do
        count = 0
        for j = i, 16 do
            turtle.select(j)
            b = turtle.transferTo(i)
            if b == true then
                count = count + 1
            end
        end
        lim = 17 - i
        print(count, " / ", lim)

        if count == lim then 
            return
        end
    end
end


function inspect()
    for i = 1, 16 do
        d = turtle.getItemDetail(i)
        if d ~= nil then
            print(d.name)
            print(d.damage)
            print(d.count)
        end
    end
end