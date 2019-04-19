os.loadAPI("transformation")
os.loadAPI("stack")
os.loadAPI("scanbranchminer")

f = stack.newStack()
p = stack.newStack()
t = transformation.newTransform()

ores = scanbranchminer.loadWorthyOres()
for k, v in pairs(ores) do
    print(k, ": ", v)
end
scanbranchminer.scanAllStart(t, p, f, ores)