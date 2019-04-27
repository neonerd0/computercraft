os.loadAPI("scanbranchminer")
os.loadAPI("transformation")
os.loadAPI("stack")

t = transformation.newTransform()
s1 = stack.newStack()
s2 = stack.newStack()

ores = scanbranchminer.loadWorthyOres()
scanbranchminer.scanAllStart(t, s1, s2, ores)