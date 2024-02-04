$execute positioned 0.0 0 0.0 positioned ~$(x) ~$(y) ~$(z) positioned ~$(x_dec) ~$(y_dec) ~$(z_dec) run tp @s ~ ~ ~
data modify storage iris:output TargetPosition.pos set from entity @s Pos
kill @s
