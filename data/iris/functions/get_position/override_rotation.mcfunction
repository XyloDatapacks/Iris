#> iris:get_position/override_rotation
#
# Returns the context rotation as a vector
#
# @within iris:get_position/main
# @context input scores

scoreboard players operation $dx iris = $override_dx iris 
scoreboard players operation $dy iris = $override_dy iris 
scoreboard players operation $dz iris = $override_dz iris 