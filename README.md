# Iris Raycasting

**Iris** is a work-in-progress utility data pack for Minecraft: Java Edition 1.20.3+ designed to determine what block or entity a player is looking at, with micrometric precision and taking into account individual block geometries.

> ⚠️ Note that **Iris is currently unreleased**. Some features are not properly tested out and some features are not yet deployed. Packaging Iris in your data packs is not recommended as it may not be fully compatible with eventual releases.

## Building

The `gen_files.py` script in the `build` folder can be used to generate functions and block tags for block hitboxes, using block data pulled from [ArticData](https://github.com/Articdive/ArticData). Generated files are created in the `generated` folder and should be merged with the rest of the data pack.

Working versions of Iris (with everything built) will be made available in GitHub releases.

## Documentation

### `iris:get_target`

Casts a ray from the current position, oriented with the current rotation, and returns data on the block or entity that is found. To tell where a player is facing, starting at the eye position is needed.

```mcfunction
execute as <player> at @s anchored eyes positioned ^ ^ ^ run function iris:get_target
```

#### Output

The `result` of this function is the distance (in blocks, rounded up) before an obstacle is hit, or 0 if no block or entity is found before the maximum recursion depth is reached.

The `success` is 1 if a block or entity was hit, 0 otherwise.

Available information about the targeted position is saved to the `iris:output` storage. The exact storage output of the function is further documented in the header of the function itself (`data/iris/functions/get_target.mcfunction`).

If a block was hit, a marker with the `iris.targeted_block` tag is summoned in the middle of the targeted tile. If an entity was hit, it gets the `iris.targeted_entity` tag. When running the function again, `iris.targeted_block` markers are killed and `iris.targeted_entity` entities get the tag removed, and so there can only be one such entity in the world at any given moment.

#### Settings

Settings of the function can be modified in the `iris:settings` storage:

| Tag                 | Description                                         | Default value |
|---------------------|-----------------------------------------------------|---------------|
| `MaxRecursionDepth` | How many blocks to traverse before giving up        | 16            |
| `TargetEntities`    | Whether or not to look for collisions with entities | `false`       |
| `Blacklist`         | Which blocks to ignore during block traversal       | `"#iris:air"` |
| `Whitelist`         | The only blocks to look for during traversal        | N/A           |

If both `Blacklist` and `Whitelist` are set, all blocks outside of the whitelist or in the blacklist will be ignored. If both `Blacklist` and `Whitelist` are unset, collisions will be tested for all tiles traversed. It is recommended that blocks with no outline (e.g. `air`) be blacklisted, or that a whitelist be set up to ignore them.

#### Examples

##### Detecting when the player is looking at a block that is within reach

In the following example, it is assumed that the function is executed as each player. A message is displayed in the actionbar of players targeting a block. The block reach is 5 blocks in creative mode, 4.5 blocks in survival mode. 

```mcfunction
# Detect when the player is looking at a block that is within reach
execute if entity @s[gamemode=survival] run scoreboard players set $max_distance mypack 4500000
execute if entity @s[gamemode=creative] run scoreboard players set $max_distance mypack 5000000
execute at @s anchored eyes positioned ^ ^ ^ store result score $distance mypack run function iris:get_target
title @s actionbar ""
execute if score $distance mypack <= $max_distance mypack at @e[type=minecraft:marker, tag=iris.targeted_block] run title @s actionbar "Looking at a block"
```

##### Targeting entities that the player looks at

In the following example, levitation is given to cows that the player looks at within a 10 block radius. It is assumed that `TargetEntities` has been set to true, and that `MaxRecursionDepth` has been set to a high enough value to catch everything within ten blocks; `20` is enough.

```mcfunction
# Give levitation to cows the player is looking at
execute as <player> at @s anchored eyes positioned ^ ^ ^ run function iris:get_target
execute at <player> run effect give @e[type=minecraft:cow, tag=iris.targeted_entity, distance=..10] minecraft:levitation 1 0
```

##### Targeting hidden blocks

In the following example, a sound is played at the location of diamond ores that the player looks at, including through other blocks.

```mcfunction
# Play a sound at diamond ores the player looks at, including through other blocks
data modify storage iris:settings Whitelist set value "#mypack:diamond_ores"
execute at @s anchored eyes positioned ^ ^ ^ run function iris:get_target
execute if data storage iris:output {TargetType: "BLOCK"} at @e[type=minecraft:marker, tag=iris.targeted_block] run playsound minecraft:block.note_block.bell block

```
```json
// data/mypack/tags/blocks/diamond_ores.json
{
    "values": [
        "minecraft:diamond_ore",
        "minecraft:deepslate_diamond_ore"
    ]
}
```

### `iris:set_coordinates`

Teleports the executing entity to a position provided by six scores on the `iris` objective: `$[x]`, `$[y]`, `$[z]` for integer coordinates, `${x}`, `${y}`, `${z}` for fractional coordinates (with a scale of 1,000,000). After running `iris:get_target`, the six scores are set to the exact position where the ray lands and so `iris:get_target` and `iris:set_coordinates` can easily be used in conjunction:

```mcfunction
# Teleport the player where they are looking
execute as <player> at @s anchored eyes positioned ^ ^ ^ run function iris:get_target
execute as <player> run function iris:set_coordinates
```

#### Output

The `result` and `success` of this function is 1 if executed by an entity, 0 otherwise.

## Including Iris in your data pack

To include Iris in your own data pack:
- Copy the `iris` folder and its contents in the `data` folder of your data pack
- Make sure the `#minecraft:load` function tag includes `iris:setup/load`

If you are redistributing modified versions of Iris as a part of your own data packs, it is recommended to change the `iris` namespace to avoid conflicts with other data packs using Iris. To do so, you may simply rename the `iris` folder to e.g. `iris_mypack` and every instance of `iris` in the contents of data pack files to `iris_mypack` (including storage names, objectives, entity tags...)

## How it works

Since this will most likely be used mostly by other data pack nerds, here is a summary of how Iris operates.

### Getting the coordinates/rotation

`execute store` can be used to get an entity's position, however any scale over 70 is unusable for X and Z coordinates due to overflowing. To get the current position with enough detail, string manipulation is done with macro functions to cut and read everything past the decimal point in any position coordinate. From then on, the starting position is saved as six scores: the integer part (`$[x]`, `$[y]`, `$[z]`) and the fractional part (`${x}`, `${y}`, `${z}`).

To get the rotation, a marker is summoned 1,000,000 blocks forward starting from `0.0`, `0.0`, `0.0` using the executing rotation. The marker's position describes the rotation as a steering vector that can be used in later calculations.

### Raycasting

The data pack solves simple linear equations to figure out which tile it hits next (ray/plane intersections), instead of progressing by a fixed length at every iteration like most raycasting functions do. Upon hitting a block other than air (or an entity, if `TargetEntities` is true), it gets its shape as a list of axis-aligned bounding boxes (AABB) and checks which faces it hits. For every AABB, there are three surfaces to check, and the three others (back-faces) are culled.
