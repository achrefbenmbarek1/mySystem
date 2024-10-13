#!/usr/bin/env bash

bookmark_file=/home/achref/.my_tmux_bookmarks

if [[ ! -f "$bookmark_file" ]]; then
    notify-send "No bookmarks found, over"
    exit 1
fi

mapfile -t bookmarks < "$bookmark_file"

for session in "${bookmarks[@]}"; do
    echo "$session"
    selected_name=$(basename "$session" | tr . _)
    tmux new-session -ds "$selected_name" -c "$session" \; split-window -v -l 20% -c "$session"
    notify-send "session created, over"
done


