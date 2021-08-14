#> iris:get_block_surfaces/block/doors
#
# @within iris:get_block_surfaces/main

# open=false
execute if block ~ ~ ~ #minecraft:doors[facing=east, open=false] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 187500, 1000000, 1000000]], Bottom: [[0, 0, 0, 187500, 0, 1000000]], West: [[0, 0, 0, 0, 1000000, 1000000]], East: [[187500, 0, 0, 187500, 1000000, 1000000]], North: [[0, 0, 0, 187500, 1000000, 0]], South: [[0, 0, 1000000, 187500, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=west, open=false] run data modify storage iris:block Surfaces set value {Top: [[812500, 1000000, 0, 1000000, 1000000, 1000000]], Bottom: [[812500, 0, 0, 1000000, 0, 1000000]], West: [[812500, 0, 0, 812500, 1000000, 1000000]], East: [[1000000, 0, 0, 1000000, 1000000, 1000000]], North: [[812500, 0, 0, 1000000, 1000000, 0]], South: [[812500, 0, 1000000, 1000000, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=north, open=false] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 812500, 1000000, 1000000, 1000000]], Bottom: [[0, 0, 812500, 1000000, 0, 1000000]], West: [[0, 0, 812500, 0, 1000000, 1000000]], East: [[1000000, 0, 812500, 1000000, 1000000, 1000000]], North: [[0, 0, 812500, 1000000, 1000000, 812500]], South: [[0, 0, 1000000, 1000000, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=south, open=false] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 1000000, 1000000, 187500]], Bottom: [[0, 0, 0, 1000000, 0, 187500]], West: [[0, 0, 0, 0, 1000000, 187500]], East: [[1000000, 0, 0, 1000000, 1000000, 187500]], North: [[0, 0, 0, 1000000, 1000000, 0]], South: [[0, 0, 187500, 1000000, 1000000, 187500]]}

# open=true, hinge=left
execute if block ~ ~ ~ #minecraft:doors[facing=east, open=true, hinge=left] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 1000000, 1000000, 187500]], Bottom: [[0, 0, 0, 1000000, 0, 187500]], West: [[0, 0, 0, 0, 1000000, 187500]], East: [[1000000, 0, 0, 1000000, 1000000, 187500]], North: [[0, 0, 0, 1000000, 1000000, 0]], South: [[0, 0, 187500, 1000000, 1000000, 187500]]}
execute if block ~ ~ ~ #minecraft:doors[facing=west, open=true, hinge=left] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 812500, 1000000, 1000000, 1000000]], Bottom: [[0, 0, 812500, 1000000, 0, 1000000]], West: [[0, 0, 812500, 0, 1000000, 1000000]], East: [[1000000, 0, 812500, 1000000, 1000000, 1000000]], North: [[0, 0, 812500, 1000000, 1000000, 812500]], South: [[0, 0, 1000000, 1000000, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=north, open=true, hinge=left] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 187500, 1000000, 1000000]], Bottom: [[0, 0, 0, 187500, 0, 1000000]], West: [[0, 0, 0, 0, 1000000, 1000000]], East: [[187500, 0, 0, 187500, 1000000, 1000000]], North: [[0, 0, 0, 187500, 1000000, 0]], South: [[0, 0, 1000000, 187500, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=south, open=true, hinge=left] run data modify storage iris:block Surfaces set value {Top: [[812500, 1000000, 0, 1000000, 1000000, 1000000]], Bottom: [[812500, 0, 0, 1000000, 0, 1000000]], West: [[812500, 0, 0, 812500, 1000000, 1000000]], East: [[1000000, 0, 0, 1000000, 1000000, 1000000]], North: [[812500, 0, 0, 1000000, 1000000, 0]], South: [[812500, 0, 1000000, 1000000, 1000000, 1000000]]}

# open=true, hinge=right
execute if block ~ ~ ~ #minecraft:doors[facing=east, open=true, hinge=right] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 812500, 1000000, 1000000, 1000000]], Bottom: [[0, 0, 812500, 1000000, 0, 1000000]], West: [[0, 0, 812500, 0, 1000000, 1000000]], East: [[1000000, 0, 812500, 1000000, 1000000, 1000000]], North: [[0, 0, 812500, 1000000, 1000000, 812500]], South: [[0, 0, 1000000, 1000000, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=west, open=true, hinge=right] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 1000000, 1000000, 187500]], Bottom: [[0, 0, 0, 1000000, 0, 187500]], West: [[0, 0, 0, 0, 1000000, 187500]], East: [[1000000, 0, 0, 1000000, 1000000, 187500]], North: [[0, 0, 0, 1000000, 1000000, 0]], South: [[0, 0, 187500, 1000000, 1000000, 187500]]}
execute if block ~ ~ ~ #minecraft:doors[facing=north, open=true, hinge=right] run data modify storage iris:block Surfaces set value {Top: [[812500, 1000000, 0, 1000000, 1000000, 1000000]], Bottom: [[812500, 0, 0, 1000000, 0, 1000000]], West: [[812500, 0, 0, 812500, 1000000, 1000000]], East: [[1000000, 0, 0, 1000000, 1000000, 1000000]], North: [[812500, 0, 0, 1000000, 1000000, 0]], South: [[812500, 0, 1000000, 1000000, 1000000, 1000000]]}
execute if block ~ ~ ~ #minecraft:doors[facing=south, open=true, hinge=right] run data modify storage iris:block Surfaces set value {Top: [[0, 1000000, 0, 187500, 1000000, 1000000]], Bottom: [[0, 0, 0, 187500, 0, 1000000]], West: [[0, 0, 0, 0, 1000000, 1000000]], East: [[187500, 0, 0, 187500, 1000000, 1000000]], North: [[0, 0, 0, 187500, 1000000, 0]], South: [[0, 0, 1000000, 187500, 1000000, 1000000]]}