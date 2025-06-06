HOW TO CUSTOMIZE THE PACK (IT WILL NOT DO ANYTHING UNLESS YOU CUSTOMIZE)

in the pack, go to assets/minecraft/shaders/include/settings.glsl

hitbox_direction: line pointing where you look
hitbox_eye: line at eye level
hitbox_box: hitbox around you
hitbox_width: width of hitbox lines
block_outline: the block outline
block_outline_width: width of block outline
hit: color things turn when hit
glint: enchantment glint color

each setting has a few parts:
setting_color: (red, green, blue), all 0-255
setting_opacity: transparency, 0 is invisible, 255 is fully visible. 0-255
setting_rainbow: true or false, all lowercase. if true will replace color with rainbow

setting_width: width of the line. any value with a decimal place, eg 1.5 or 3.0

YOU NEED FABULOUS GRAPHICS FOR THIS:
in assets/minecraft/shaders/program/transparency.fsh
hue_change: changes the colors of everything on screen, any number
sat_percent: makes everything more/less saturated, any number
val_percent: makes everything brighter/darker, any number

if you change settings during game, use F3+T to reload resource packs