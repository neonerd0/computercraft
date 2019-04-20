modules = {}
modules['move'] = "bmmcwQMQ"
modules['floor'] = "yv6hM2Db"
modules['inventory'] = "LMALtJ6r"
modules['vector'] = "zSHkmeDv"
modules['rotational'] = "JSd0jxL8"
modules['transformation'] = "HVMqpjrT"
modules['room'] = "7AvQUPqY"
modules['downminer'] = "X6GPgYFK"
modules['dump'] = "WP2tv1t5"
modules['stack'] = "zgYztk42"
modules['test'] = "PLdr2YHf"
modules['ore_worthy'] = "BHV9MseC"
modules['scanbranchminer'] = "SiuW9VWV"
modules['inspect'] = "HJ6ttxpt"

print("Patching modules...")

for k, v in pairs(modules) do
    print(k, "...")
    shell.run("rm", k)
    shell.run("pastebin", "get", v, k)
end