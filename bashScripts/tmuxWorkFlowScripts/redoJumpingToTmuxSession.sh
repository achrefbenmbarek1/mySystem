#!/usr/bin/env bash

undo_session_file="/tmp/undo_session.txt"
redo_session_file="/tmp/redo_session.txt"
attached_session_file="/tmp/attached_tmux_session.txt"

# Function to read the currently attached session from file
read_attached_session() {
    if [ -f "$attached_session_file" ]; then
        cat "$attached_session_file"
    fi
}

# Function to write the selected session to file
write_selected_session() {
    echo "$1" > "$attached_session_file"
}

attachedSession=$(read_attached_session)
attachedSessionName=$(basename "$attachedSession" | tr . _)
# readLastElementInUndoHistory=$(tail -n 2 "$redo_session_file" | head -n 1)
readLastElementInRedoHistory=$(cat $redo_session_file | tail -n 1)
echo "$readLastElementInRedoHistory"
# readLastElementInUndoHistoryLiterallyAndWhatUsedToBeTheCurrentSession=$(tail -n 1 "$redo_session_file")
numberOfSessionsInTheUndoList=$(wc -l < "$redo_session_file")

if [[ $numberOfSessionsInTheUndoList -lt 2 ]]; then
    notify-send "damn"
    exit 0
fi

# Get window information using hyprctl
window_info=$(hyprctl clients -j)
# Find the terminal window ID (replace "Terminal" with your terminal's title or class)
terminal_window_id=$(echo "$window_info" | jq -r '.[] | select(.title=="dev") | .workspace.id' | head -n 1)

# Function to focus an existing terminal window or open a new one
focus_terminal_window() {
        tmux detach -s "$attachedSessionName"
        hyprctl dispatch workspace "$terminal_window_id"
        hyprctl dispatch exec "alacritty --title 'dev' -e sh -c 'tmux attach-session -t $readLastElementInRedoHistory'"
        echo "$readLastElementInRedoHistory" >> "$undo_session_file"
        sed -i '$d' "$redo_session_file"

        write_selected_session "$readLastElementInRedoHistory"
        notify-send "Switched to tmux session: $readLastElementInRedoHistory"
    # else
    #     # Open a new terminal and attach the tmux session if no terminal is found
    #     hyprctl dispatch workspace 3
    #     hyprctl dispatch exec "alacritty -e sh -c 'tmux attach-session -t $readLastElementInUndoHistoryLiterallyAndWhatUsedToBeTheCurrentSession'"
}


# Focus or open the terminal window
    if [[ -n $terminal_window_id ]]; then
focus_terminal_window
else
notify-send "you're not attached to any tmux session currently"
    fi



