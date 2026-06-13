#!/bin/bash
# Путь к каталогу с обоями
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
WALLPAPER_LINE=5
# Выбор обоев с помощью rofi
SELECTED_WALLPAPER=$(for a in "$WALLPAPER_DIR"/*; do
    echo -en "$(basename "$a")\0icon\x1f$a\n"
done | rofi -dmenu -p " " -theme ~/.config/rofi/select.rasi)

if [ -n "$SELECTED_WALLPAPER" ]; then
 	 awww img "$WALLPAPER_DIR/$SELECTED_WALLPAPER" --transition-fps 120 --transition-type any --transition-duration 1.5
 	 IMAGE_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER"
 # Формируем новую строку с путём
    NEW_PATH="    path = $WALLPAPER_DIR/$SELECTED_WALLPAPER"

    # Заменяем 6-ю строку целиком
    sed -i "${WALLPAPER_LINE}s|.*|$NEW_PATH|" "$HYPRLOCK_CONF"

	 # применяем тему к приложениям через pywal
	 # wal -i $WALLPAPER_DIR/$SELECTED_WALLPAPER
	 wal -n --cols16 -i $WALLPAPER_DIR/$SELECTED_WALLPAPER
	 ~/.config/hypr/scripts/update_colors_css.sh
	 ~/.config/hypr/scripts/update_colors_scss.sh
	 ~/.config/hypr/scripts/make_rasi_colors.sh
	 ~/.config/hypr/scripts/make_conf_colors.sh
	 killall waybar && waybar &

	 sed -i "59c\    background-image:            url(\""$WALLPAPER_DIR"/"$SELECTED_WALLPAPER"\", height);" ~/.config/rofi/launchers/type-6/style-1.rasi
	 sed -i "64c\    background-image:            url(\""$WALLPAPER_DIR"/"$SELECTED_WALLPAPER"\", height);" ~/.config/rofi/applets/type-5/style-2.rasi

	 cp ~/.cache/wal/colors-wal.vim ~/.config/nvim/colors

	 killall eww
	 killall volume.sh
	 ~/.config/eww/volume-indicator/scripts/volume.sh &
	 ~/.config/hypr/scripts/update_cava_colors.sh
fi
