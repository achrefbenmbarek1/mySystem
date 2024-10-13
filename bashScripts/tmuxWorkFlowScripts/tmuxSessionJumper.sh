#!/usr/bin/env bash

# Paths for session files
attached_session_file="/tmp/attached_tmux_session.txt"
undo_session_file="/tmp/undo_session.txt"

# List tmux sessions and present them in Rofi
sessions=$(tmux list-sessions -F "#S")
selected_session=$(echo "$sessions" | rofi -dmenu -p "Select or switch to session:")

# Function to append a line to the start of the undo file
append_line_to_the_start_of_the_undo_file() {
    echo "$1" | cat - "$undo_session_file" > /tmp/temporary.txt && mv /tmp/temporary.txt "$undo_session_file"
}

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

# Check if a session was selected
if [[ -z "$selected_session" ]]; then
    notify-send "You didn't select a session."
    exit 0
fi

# Prompt for action (CloseSession or Attach)
choice=$(echo -e "CloseSession\nAttach" | rofi -dmenu -p "Choose action:")

if [[ "$choice" == "CloseSession" ]]; then
    potentialCurrentSession=$(read_selected_session)
    if [[ "$potentialCurrentSession" == "$selected_session" ]]; then
        echo -n > "$attached_session_file"
    fi
    tmux kill-session -t "$selected_session"
    notify-send "Selected session removed."
    exit 0
fi

# Prepare for session attachment
selectedSessionName=$(basename "$selected_session" | tr . _)
stored_session=$(read_selected_session)
stored_session_name=$(basename "$stored_session" | tr . _)

# Use Hyprland's tools to get window information and focus
window_info=$(hyprctl clients -j)
terminal_window_id=$(echo "$window_info" | jq -r '.[] | select(.title=="dev") | .workspace.id' | head -n 1)
# Function to open a new terminal and attach the tmux session
open_terminal_and_attach() {
    hyprctl dispatch workspace 3
    hyprctl dispatch exec "alacritty --title 'dev' -e sh -c 'tmux attach-session -t $selectedSessionName'"
}

# Function to focus an existing terminal window
focus_terminal_window() {
    if [[ -n $terminal_window_id ]]; then
        tmux detach -s "$stored_session_name"
        hyprctl dispatch workspace "$terminal_window_id"
        hyprctl dispatch exec "alacritty --title 'dev' -e sh -c 'tmux attach-session -t $selectedSessionName'"
        # tmux attach-session -t "$selectedSessionName"

    else
        open_terminal_and_attach
    fi
}

if [[ -z "$terminal_window_id" ]]; then
    # No terminal found, open a new one and attach the tmux session
    open_terminal_and_attach
else
    # Terminal exists, focus it and attach the tmux session
    focus_terminal_window
    # if [ -n "$stored_session" ]; then
    #     tmux detach -s "$stored_session_name"
    # fi
    # tmux attach-session -t "$selectedSessionName"
fi

# Update bookmark files
echo "$selectedSessionName" >> "$undo_session_file"
write_selected_session "$selected_session"

notify-send "Session started."

