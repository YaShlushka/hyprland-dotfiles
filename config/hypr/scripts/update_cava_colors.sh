#!/bin/bash

COLORS="$HOME/.cache/wal/colors"
C1=$(sed -n '2p' "$COLORS" | cut -c1-7)
C2=$(sed -n '3p' "$COLORS" | cut -c1-7)
C3=$(sed -n '4p' "$COLORS" | cut -c1-7)
C4=$(sed -n '5p' "$COLORS" | cut -c1-7)
C5=$(sed -n '6p' "$COLORS" | cut -c1-7)
C6=$(sed -n '7p' "$COLORS" | cut -c1-7)
C7=$(sed -n '8p' "$COLORS" | cut -c1-7)
C8=$(sed -n '9p' "$COLORS" | cut -c1-7)

sed -i "163c\gradient_color_1 = '$C1'" ~/.config/cava/config
sed -i "164c\gradient_color_2 = '$C2'" ~/.config/cava/config
sed -i "165c\gradient_color_3 = '$C3'" ~/.config/cava/config
sed -i "166c\gradient_color_4 = '$C4'" ~/.config/cava/config
sed -i "167c\gradient_color_5 = '$C5'" ~/.config/cava/config
sed -i "168c\gradient_color_6 = '$C6'" ~/.config/cava/config
sed -i "169c\gradient_color_7 = '$C7'" ~/.config/cava/config
sed -i "170c\gradient_color_8 = '$C8'" ~/.config/cava/config
