# Computercraft turtle scripts

This repository is a collection of API functions for Computercraft's Turtle programming. This includes low level APIs such as `tranform` and `stack` as well as higher level APIs such as `room`, `downminer` and `scan branch miner`.

<i>WIP: Documentation for each API and usage</i>



## Installation & Dependencies

You will need the following mods:

- Computercraft 1.75
- OpenComputers 1.7.3 (And OpenComputers Core 1.7.3)
- OpenPeripheralAddon 0.6
- OpenPeripheralCore 1.4
- OpenPeripheralIntegration 0.6

And minecraft itself.

If you want to get up and running quickly you can use my [pastebin](https://pastebin.com/xnd08s82). Place a Turtle and type into the shell:

```
pastebin get xnd08s82 update
update
```

This will pull the patcher and download all the exportable modules (LUA turtle scripts) into your Turtle.

If you wish to use your own pastebin you can edit the files:

- [masterupdate.lua](api/patcher.api/masterupdate.lua)
- [patcher.lua](api/patcher.api/patcher.lua)

Simply fix all the patebin url hashes to point to those which you have uploaded.
An alternative is to use `http api` to wget/pull the files directly off git.

# WIP Stuff
### guardian.lua
- Follows the player around
- Can assign patrol routes
- Attacks mobs that are nearby

### [downminer.lua](api/miner.api/downminer.lua)
- Ender IO chest support
- Refuel support
- GPS support
- BFS optimization

### [transformation.lua](api/transform.api/transformation.api)
- Refactor code to use `self` and `metatable` to emulate `classes`
- Optimize rotation code 
- Optimize `gotoPosition` function
- Support GPS coordinate system

### builder.api

No code yet but planned scripts are:

- frame.lua --> construct a 4 legged frame using blocks (slants and non-slanted frames)
- shell.lua --> construct walls inbetween frames using blocks (follows the frames)
- floor.lua --> Previously in miner.api currently code is broken
