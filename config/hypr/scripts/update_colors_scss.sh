#!/bin/bash

SCRIPT="$HOME/.config/hypr/scripts/wal_css_hex_to_rgba.sh"
DST="$HOMe/.config/waybar/color_scheme.scss"

main_bg=$($SCRIPT --background 0.8)
main_fg=$($SCRIPT --foreground 1)
wb_act_bg=$($SCRIPT --foreground 0.9)
wb_hvr_bg=$($SCRIPT --color8 0.4)
wb_hvr_fg=$($SCRIPT --foreground 0.8)
color1=$($SCRIPT --color1 1)

sed -i "2c\$main-bg: $main_bg;" ~/.config/waybar/color_scheme.scss
sed -i "3c\$main-fg: $main_fg;" ~/.config/waybar/color_scheme.scss
sed -i "4c\$wb-act-bg: $wb_act_bg;" ~/.config/waybar/color_scheme.scss
sed -i "6c\$wb-hvr-bg: $wb_hvr_bg;" ~/.config/waybar/color_scheme.scss
sed -i "7c\$wb-hvr-fg: $wb_hvr_fg;" ~/.config/waybar/color_scheme.scss
sed -i "8c\$color1: $color1;" ~/.config/waybar/color_scheme.scss
