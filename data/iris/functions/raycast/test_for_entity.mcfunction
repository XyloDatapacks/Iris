#> iris:raycast/test_for_entity
#
# @output
#   Result: 0
#   Success: 1 if an entity was hit, 0 otherwise

execute unless data storage iris:settings {TargetEntities: true} run return fail
execute if score $entity_hitbox_tollerance iris matches 0 align xyz unless entity @e[type=!#iris:ignore, tag=!iris.ignore, dx=0, dy=0, dz=0, tag=!iris.executing] run return fail
execute if score $entity_hitbox_tollerance iris matches 0 align xyz as @e[type=!#iris:ignore, tag=!iris.ignore, dx=0, dy=0, dz=0, tag=!iris.executing] run function iris:get_hitbox/entity
execute unless score $entity_hitbox_tollerance iris matches 0 align xyz positioned ~-1 ~-1 ~-1 unless entity @e[type=!#iris:ignore, tag=!iris.ignore, dx=2, dy=2, dz=2, tag=!iris.executing] run return fail
execute unless score $entity_hitbox_tollerance iris matches 0 align xyz positioned ~-1 ~-1 ~-1 as @e[type=!#iris:ignore, tag=!iris.ignore, dx=2, dy=2, dz=2, tag=!iris.executing] positioned ~1 ~1 ~1 run function iris:get_hitbox/entity
return run function iris:raycast/check_intersection/loop
