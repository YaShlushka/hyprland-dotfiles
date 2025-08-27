#!/bin/bash
# Usage: wal_css_hex_to_rgba.sh <variable> [alpha], for example wal_css_hex_to_rgba.sh --background 1

colors_file="${WAL_COLORS_FILE:-$HOME/.cache/wal/colors.css}"

var="$1"
alpha="${2:-1}"

if [[ -z "$var" ]]; then
    echo "Укажите имя переменной, например: --background"
    exit 1
fi

# Извлечь hex из файла палитры
hex=$(grep -m1 -- "$var:" "$colors_file" | awk -F: '{print $2}' | tr -d '; ')

if [[ -z "$hex" ]]; then
    echo "Переменная $var не найдена в $colors_file"
    exit 2
fi

# Удалить символ #
hex="${hex/#\#}"

if [[ ${#hex} -ne 6 ]]; then
    echo "Цвет в переменной $var не 6-символьный hex: $hex"
    exit 3
fi

r=$((16#${hex:0:2}))
g=$((16#${hex:2:2}))
b=$((16#${hex:4:2}))

echo "rgba($r, $g, $b, $alpha)"
