#!/usr/bin/env bash

bookmark_file=~/.my_tmux_bookmarks

if [[ ! -f "$bookmark_file" ]]; then
    notify-send "No bookmarks found."
    exit 1
fi

mapfile -t bookmarks < "$bookmark_file"

selected_sessions=$(printf "%s\n" "${bookmarks[@]}" | rofi -dmenu -multi-select -p "Select bookmarked sessions:")

if [[ -z "$selected_sessions" ]]; then
    notify-send "no sessions selected"
    exit 0
fi

action=$(echo -e "Create\nRemove" | rofi -dmenu -p "Choose action for selected sessions:")

case "$action" in
    "Create")
        for session in $selected_sessions; do
            selected_name=$(basename "$session" | tr . _)
            tmux new-session -ds $selected_name -c $session \; split-window -v -l 20% -c $session
            notify-send "sessions created"
    exit 0

        done
        ;;
    "Remove")
        for session in $selected_sessions; do
            sed -i "\~$session~d" "$bookmark_file"
        done
        notify-send "Removed selected sessions from bookmarks."
        ;;
    *)
        notify-send "Invalid action."
        ;;
esac


