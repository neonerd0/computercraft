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