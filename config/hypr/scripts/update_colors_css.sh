#!/bin/bash

SRC="$HOME/.config/hypr/scripts/wal_css_hex_to_rgba.sh"

main_bg=$($SRC --background 0.8)
main_fg=$($SRC --foreground 1)
wb_act_bg=$($SRC --foreground 0.9)
wb_hvr_bg=$($SRC --color8 0.4)
wb_hvr_fg=$($SRC --foreground 0.8)
black=$($SRC --color0 1)
red=$($SRC --color1 1)
green=$($SRC --color2 1)
yellow=$($SRC --color3 1)
blue=$($SRC --color4 1)
purple=$($SRC --color5 1)
cyan=$($SRC --color6 1)
white=$($SRC --color7 1)
gray=$($SRC --color8 1)

# sed -i "s|@define-color main-bg .*;|@define-color main-bg $main_bg;|" ~/.config/waybar/color_scheme.css
# sed -i "s|@define-color main-fg .*;|@define-color main-fg $main_fg;|" ~/.config/waybar/color_scheme.css
# sed -i "s|@define-color wb-act-bg .*;|@define-color wb-act-bg $wb_act_bg;|" ~/.config/waybar/color_scheme.css
# sed -i "s|@define-color wb-hvr-bg .*;|@define-color wb-hvr-bg $wb_hvr_bg;|" ~/.config/waybar/color_scheme.css
# sed -i "s|@define-color wb-hvr-fg .*;|@define-color wb-hvr-fg $wb_hvr_fg;|" ~/.config/waybar/color_scheme.css

cat > "$HOME/.config/waybar/color_scheme.css" <<EOF
@define-color main-bg $main_bg;
@define-color main-fg $main_fg;
@define-color wb-act-bg $wb_act_bg;
@define-color wb-act-fg rgba(0,0,0,0.7);
@define-color wb-hvr-bg $wb_hvr_bg;
@define-color wb-hvr-fg $wb_hvr_fg;
@define-color black $black;
@define-color red $red;
@define-color green $green;
@define-color yellow $yellow;
@define-color blue $blue;
@define-color purple $purple;
@define-color cyan $cyan;
@define-color white $white;
@define-color gray $gray;
EOF
