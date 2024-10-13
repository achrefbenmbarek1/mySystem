#!/usr/bin/env bash

attached_session_file="/tmp/attached_tmux_session.txt"

# Function to read the currently attached session from file
read_attached_session() {
    if [ -f "$attached_session_file" ]; then
        cat "$attached_session_file"
    fi
}

attachedSession=$(read_attached_session)
attachedSessionName=$(basename "$attachedSession" | tr . _)

# Check if a session is attached
if [[ -z "$attachedSession" ]]; then
    notify-send "No session is attached."
    exit 1
fi


# Detach the tmux session
tmux detach -s "$attachedSessionName"
hyprctl dispatch
# Clear the attached session file
echo -n > "$attached_session_file"

notify-send "Session detached."
