#!/bin/bash

active_win_id=$(hyprctl activewindow -j | jq -r '.address')

proc_name=$(hyprctl clients -j | jq -r --arg win "$active_win_id" '
    .[] | select(.address == $win) | .class
')

terminate_pid() {
    local pid=$1
    if [[ -n "$pid" ]]; then
        kill -TERM "$pid"
	 fi
}

if [[ "$proc_name" == "Chromium" ]]; then
    pid=$(hyprctl clients -j | jq -r --arg win "$active_win_id" '
        .[] | select(.address == $win) | .pid
    ')
    terminate_pid "$pid"
elif [[ "$proc_name" == "Spotify" ]]; then
    # Корректно завершить Spotify через flatpak kill
    flatpak kill com.spotify.Client
else
    hyprctl dispatch closeactive
fi
