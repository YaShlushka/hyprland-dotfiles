#!/bin/bash

SRC="$HOME/.cache/wal/colors-rofi-dark.rasi"
DST="$HOME/.config/hypr/colors.conf"

DATE_FG=$(sed -n '25p' "$SRC" | cut -c18-23)bf
INPUT_FG=$(sed -n '16p' "$SRC" | cut -c34-39)cc
INPUT_BG=$(sed -n '24p' "$SRC" | cut -c18-23)66

cat > "$DST" <<EOF
\$date_fg=rgba($DATE_FG)
\$input_fg=rgba($INPUT_FG)
\$input_bg=rgba($INPUT_BG)
EOF
