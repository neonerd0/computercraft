modules = {}
modules['move'] = "bmmcwQMQ"
modules['floor'] = "yv6hM2Db"
modules['inventory'] = "LMALtJ6r"
modules['vector'] = "zSHkmeDv"
modules['rotational'] = "JSd0jxL8"
modules['transformation'] = "HVMqpjrT"
modules['room2'] = "7AvQUPqY"
modules['downminer'] = "X6GPgYFK"
modules['test'] = "PLdr2YHf"

print("Patching modules...")

for k, v in pairs(modules) do
    print(k, "...")
    shell.run("rm", k)
    shell.run("pastebin", "get", v, k)
end