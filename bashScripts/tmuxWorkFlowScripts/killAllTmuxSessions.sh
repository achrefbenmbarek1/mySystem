#!/bin/bash

# Function to send commands to Neovim to save and quit
close_neovim() {
    local pane_id=$1
    local session=$2
    local window=$3

    # Make sure we start from normal mode
    echo "Sending Escape to ${session}:${window}.${pane_id}"
    tmux send-keys -t "${session}:${window}.${pane_id}" 'Escape' C-m
    sleep 0.5
    # Save all files and quit all windows
    echo "Sending :wqa! to ${session}:${window}.${pane_id}"
    tmux send-keys -t "${session}:${window}.${pane_id}" ':wqa!<Enter>' C-m
    sleep 0.5
}

# Function to check if a pane contains Neovim
contains_neovim() {
    local pane_id=$1
    local session=$2
    local window=$3

    # Check if Neovim is running in the pane
    echo "Checking if Neovim is in ${session}:${window}.${pane_id}"
    tmux capture-pane -t "${session}:${window}.${pane_id}" -p | grep -q 'nvim'
}

# Function to close Neovim windows in a single session
process_session() {
    local session=$1

    # Iterate over each window in the session
    tmux list-windows -t "$session" -F '#{window_index}' | while read -r window; do
        # Iterate over each pane in the window
        tmux list-panes -t "${session}:${window}" -F '#{pane_id}' | while read -r pane; do
            if contains_neovim "$pane" "$session" "$window"; then
                echo "Closing Neovim in ${session}:${window}.${pane}"
                close_neovim "$pane" "$session" "$window"
            fi
        done
    done
}

# Main script logic
# Iterate over each tmux session
tmux list-sessions -F '#{session_name}' | while read -r session; do
    echo "Processing session: $session"
    process_session "$session"
done

 tmux kill-server

