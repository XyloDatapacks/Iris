#> iris:get_target
#
# Returns the position of the block targeted
# To tell where a player is looking, anchoring to the eye position is needed: execute as <player> at @s anchored eyes positioned ^ ^ ^ run function iris:get_target
# Targeted block/entity information is sent to storage (see output below) but a marker with tag 'iris.ray' is also present in the targeted block after running this function
#
# @public
# @context an entity, their eye position, and their rotation
# @reads
#   storage iris:settings
#       TargetEntities: byte
#           Whether or not to look for entities
#           Defaults to false (0b)
#       MaxRecursionDepth: int
#           How many blocks to traverse before giving up
#           Defaults to 16
#       MaxDistance: double (optional, autoresets)
#           Max distance traveled by the ray
#       Blacklist: string
#           A block or a block tag to ignore
#           Defaults to "#iris:shape_groups/air"
#           Should be reset if unused, not set to an empty string
#       Whitelist: string 
#           A block or a block tag to look for (all other blocks are ignored)
#           Unset by default
#           Should be reset if unused, not set to an empty string
#       EntityHitboxTollerance: double (optional, autoresets)
#           Expand all entities hitbox by that value
#       OverrideExecutingEntity: byte (optional, autoresets)
#           If set to 1b does not add iris.executing tag to executing entity
#       OverrideRotation: byte (optional, autoresets)
#           overrides the direction vector with one already set (with absolute value 1000000)
#           $override_dx iris, $override_dy iris, $override_dz iris
# @writes
#   storage iris:output
#       TargetType: string
#           What the ray hits
#           One of "BLOCK", "ENTITY", or "NONE"
#       TargetedBlock: int[]
#           The integer coordinates of the block that is hit
#           Corresponds to the "Targeted Block" field in the debug screen
#           Unset if TargetType is not BLOCK
#       TargetedEntity
#           UUID: int[]
#               Entity's uuid
#           id: int
#               The ID of the targeted entity on objective iris.entity_id
#               The entity executing this function cannot be targeted
#           Unset if TargetType is not ENTITY
#       TargetPosition
#           Unset if TargetType is NONE
#           tile: int[]
#               The integer coordinates of the last traversed tile
#           pos: double[]
#               The double coordinates of the last traversed tile
#           point: double[]
#               Where exactly the ray hits an obstacle within the last traversed tile, as three coordinates between 0 and 1
#       PlacePosition
#           Unset if TargetType is NONE
#           tile: int[]
#               The integer coordinates of where a block would be placed
#       Distance: double
#           How long the ray travels before hitting an obstacle
#           Unset if TargetType is NONE
#       TargetedBox: compound
#           The axis-aligned bounding box that was hit within the last traversed tile, as six coordinates between 0 and 1
#           Unset if TargetType is NONE
#           min: double[]
#           max: double[]
#       TargetedFace: compound
#           The face ŧhat was hit within the last traversed tile, as six coordinates between 0 and 1
#           Unset if TargetType is NONE
#           min: double[]
#           max: double[]
#           Direction: string
#              Which face of the obstacle is hit
#              One of WEST, EAST, UP, DOWN, NORTH, SOUTH
#   score $total_distance iris
#       The distance (in µm) travelled by the ray before it hits a block
#       Unset if no block or entity is found
# @output
#   Result: The distance (in blocks, rounded up) before an obstacle is hit, 0 if no block or entity is found
#   Success: 1 if a block or entity was hit, 0 otherwise

# Reset tags, scores and storage
tag @e remove iris.targeted_entity
tag @e remove iris.potential_target
kill @e[type=minecraft:marker, tag=iris.targeted_block]
scoreboard players reset * iris.id

data modify storage iris:output TargetType set value "NONE"
data remove storage iris:output TargetedBlock
data remove storage iris:output TargetedEntity
data remove storage iris:output TargetPosition
data remove storage iris:output PlacePosition
data remove storage iris:output Distance
data remove storage iris:output TargetedBox
data remove storage iris:output TargetedFace

execute store result score $entity_hitbox_tollerance iris run data get storage iris:settings EntityHitboxTollerance 1000000
execute if score $entity_hitbox_tollerance iris matches ..0 run scoreboard players set $entity_hitbox_tollerance iris 0
execute if score $entity_hitbox_tollerance iris matches 1000000.. run scoreboard players set $entity_hitbox_tollerance iris 1000000
data remove storage iris:settings EntityHitboxTollerance

scoreboard players set $depth iris 0
scoreboard players set $min_distance iris 2147483647
scoreboard players set $max_entity_id iris 0
scoreboard players set $total_distance iris 0

# Get initial position/rotation
execute summon minecraft:marker run function iris:get_position/main
data remove storage iris:settings OverrideRotation

# Start the loop
execute unless data storage iris:settings {OverrideExecutingEntity:1b} run tag @s add iris.executing
data remove storage iris:settings OverrideExecutingEntity
execute store result score $max_depth iris run data get storage iris:settings MaxRecursionDepth
execute store result score $max_distance iris run data get storage iris:settings MaxDistance 1000000
execute if score $max_distance iris matches ..0 run scoreboard players set $max_distance iris 2147483647
data remove storage iris:settings MaxDistance
return run function iris:raycast/loop
