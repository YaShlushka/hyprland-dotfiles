#!/bin/bash

# Пути к файлам
SRC="$HOME/.cache/wal/colors-rofi-dark.rasi"
DST="$HOME/.config/rofi/colors.rasi"

BACKGROUND=$(sed -n '24p' "$SRC" | cut -c17-23)e6
FOREGROUND=$(sed -n '25p' "$SRC" | cut -c17-23)ff
SELECT_BG=$(sed -n '16p' "$SRC" | cut -c33-39)ff
SEARCH_FIELD=$(sed -n '25p' "$SRC" | cut -c17-23)0f
SELECT_URGENT_BG=$(sed -n '20p' "$SRC" | cut -c33-39)ff
URGENT=$(sed -n '6p' "$SRC" | cut -c24-30)ff
cat > "$DST" <<EOF
* {
    main-bg:    			$BACKGROUND;
    main-fg:    			$FOREGROUND;
    main-br:            $SELECT_BG;
    select-urgent-bg:   $SELECT_URGENT_BG;
    select-bg:          $SELECT_BG;
    select-fg:          $BACKGROUND;
    separatorcolor:     transparent;
    border-color:       transparent;
	 search-field:			$SEARCH_FIELD;
	 urgent:					$URGENT;
}
EOF
