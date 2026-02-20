#!/bin/bash
DESKTOP_FILE="/usr/share/applications/nvim.desktop"

if grep -q "Terminal=true" "$DESKTOP_FILE"; then
    sed -i 's/^Terminal=true/Terminal=false/' "$DESKTOP_FILE"
fi

if grep -q "Exec=nvim %F" "$DESKTOP_FILE"; then
    sed -i 's/^Exec=nvim %F/Exec=kitty nvim %F/' "$DESKTOP_FILE"
fi
