#!/usr/bin/env bash

# Tmux is a dependency. This is a check
if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Please install tmux to use this script."
    exec bash
    exit 1
fi
# FZF is a dependency. This is a check
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install fzf to use this script."
    exec bash
    exit 1
fi


# Default directories to search in
default_dirs=(~/)

# If an argument is passed, use it as the selected directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Otherwise, let the user pick a directory using fzf
    selected=$(find "${default_dirs[@]}" -type d | fzf)
fi

# Exit if no directory is selected (either from fzf or argument)
if [[ -z $selected ]]; then
    echo "No directory selected, exiting..."
    exec bash
    exit 1
fi

# Extract the base name of the selected directory and sanitize the session name
selected_name=$(basename "$selected" | tr -s '[:punct:]' '_')

# Check if we are already inside tmux
if [[ -z $TMUX ]]; then
    # If we're not in tmux, start a new tmux session and attach to it immediately
    tmux new-session -A -s "$selected_name" -c "$selected"
else
    # If we are in tmux, create a new detatch session and then attach to it (to avoid nested sessions)
    tmux new-session -A -ds "$selected_name" -c "$selected"
    
    # Switch to the newly created session
    tmux switch-client -t "$selected_name"
fi

# Execute bash to avoid terminal closing (I don't think this is necessary on all terminals, but on kitty the window would close without it)
exec bash
