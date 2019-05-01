os.loadAPI("chests")
os.loadAPI("inspectchest")

validChests = chests.loadValidChests()
chestList = chests.getAdjChests(validChests)

for i = 1, #chestList do
    inspectchest.peek(chestList[i])
end