#!/bin/bash

# Получаем имя исполнителя
artist=$(playerctl metadata artist 2>/dev/null)
# Получаем название трека
title=$(playerctl metadata title 2>/dev/null)

if [[ -z "$artist" || -z "$title" ]]; then
    echo " Spotify is not playing right now"
else
    echo " $artist - 「$title」"
fi

