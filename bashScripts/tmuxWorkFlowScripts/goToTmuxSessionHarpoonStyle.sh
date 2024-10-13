#!/usr/bin/env bash

attached_session_file="/tmp/attached_tmux_session.txt"
undo_session_file="/tmp/undo_session.txt"

# Check if the correct number of arguments is provided
if [[ $# -ne 1 ]]; then
    notify-send "Usage: $0 <number>"
    exit 1
fi

input_number=$1

# Function to read the currently attached session from file
read_selected_session() {
    if [ -f "$attached_session_file" ]; then
        cat "$attached_session_file"
    fi
}

# Function to write the selected session to file
write_selected_session() {
    echo "$1" > "$attached_session_file"
}

stored_session=$(read_selected_session)
storedSessionName=$(basename "$stored_session" | tr . _)

# Get the list of windows and their IDs
window_info=$(hyprctl clients -j)
# Extract terminal window ID (replace "Terminal" with your terminal's class or title)
targetWindowId=$(echo "$window_info" | jq -r '.[] | select(.title | contains("Alacritty")) | .id' | head -n 1)

# Focus the target window
if [[ -n $targetWindowId ]]; then
    hyprctl dispatch focuswindow "$targetWindowId"
fi

# Check if tmux is running and detach from the stored session if necessary
tmux_running=$(pgrep tmux)

if [[ -n $tmux_running ]]; then
    tmux detach -s "$storedSessionName"
fi

# List tmux sessions and select the one specified by input_number
sessions=()
mapfile -t sessions < <(tmux list-sessions -F "#S")
selected_session="${sessions[$((input_number - 1))]}"

# Attach to the selected tmux session
if [[ -n $selected_session ]]; then
    tmux attach-session -t "$selected_session"
    echo "$selected_session" >> "$undo_session_file"
    write_selected_session "$selected_session"
else
    notify-send "No tmux session found for number $input_number"
fi
