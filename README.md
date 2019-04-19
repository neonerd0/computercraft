# Computercraft turtle scripts

This repository is a collection of API functions for Computercraft's Turtle programming. This includes low level APIs such as `tranform` and `stack` as well as higher level APIs such as `room`, `downminer` and `scan branch miner`.

<i>WIP: Documentation for each API and usage</i>



## Installation & Dependencies

You only need to have `ComputerCraft 1.75` installed (With minecraft as well of course)

If you want to get up and running quickly you can use my pastebin. Place a Turtle and type into the shell:

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
