#!/bin/bash
# Путь к каталогу с обоями
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
WALLPAPER_LINE=6
# Выбор обоев с помощью rofi
SELECTED_WALLPAPER=$(ls "$WALLPAPER_DIR" | rofi -dmenu -i -p "Wallpaper")

if [ -n "$SELECTED_WALLPAPER" ]; then
	 swww img "$WALLPAPER_DIR/$SELECTED_WALLPAPER" --transition-fps 120 --transition-type any --transition-duration 1.5
	 
	 # Формируем новую строку с путём
    NEW_PATH="    path = $WALLPAPER_DIR/$SELECTED_WALLPAPER"

    # Заменяем 6-ю строку целиком
    sed -i "${WALLPAPER_LINE}s|.*|$NEW_PATH|" "$HYPRLOCK_CONF"
fi
