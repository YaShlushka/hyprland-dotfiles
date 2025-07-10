#!/bin/bash

# Получаем текущую раскладку клавиатуры из Hyprland
get_current_layout() {
    # Используем hyprctl для получения информации о устройствах ввода
    local layout=$(hyprctl devices | grep -A 10 "keyboard" | grep "active keymap" | head -n 1 | awk '{print $3}' | cut -c1-2)
    echo "$layout"
}

# Основная функция
main() {
    current_layout=$(get_current_layout)
    
    # Проверяем, что мы получили значение
    if [ -z "$current_layout" ]; then
        echo "Не удалось определить раскладку клавиатуры" >&2
        exit 1
    fi
    
    # Выводим результат в нижнем регистре
    echo "$current_layout" | tr '[:upper:]' '[:lower:]'
}

main "$@"
