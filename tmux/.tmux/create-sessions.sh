#!/bin/bash

# Function to create a tmux session with windows and set directory for each window
create_tmux_session() {
    local session_name=$1
    local backend_dir=$2
    local react_dir=$3
    local lazygit_dir=$4

    # Expand '~' to the full path
    backend_dir=$(eval echo $backend_dir)
    react_dir=$(eval echo $react_dir)
    lazygit_dir=$(eval echo $lazygit_dir)

    # Create the session and first window
    tmux new-session -d -s $session_name -n "backend" -c $backend_dir
    tmux send-keys -t $session_name:0 "echo 'Working in $backend_dir'" C-m

    # Create the React window (window 1)
    tmux new-window -t $session_name:1 -n "react" -c $react_dir
    tmux send-keys -t $session_name:1 "echo 'Working in $react_dir'" C-m

    # Create the Lazygit window (window 2)
    tmux new-window -t $session_name:2 -n "lazygit" -c $lazygit_dir
    tmux send-keys -t $session_name:2 "lazygit" C-m
}

# Check for session name argument
if [ -z "$1" ]; then
    echo "Please specify a session name: review-plugin, wprelay, tremendous, or paypal"
    exit 1
fi

# Determine directories based on the session name
case $1 in
    "review-plugin")
        backend_dir="~/code/wordpress/affiliate-go/"
        react_dir="~/code/wordpress/affiliate-go/wp-content/plugins/flycart-reviews/admin-ui"
        lazygit_dir="~/code/wordpress/affiliate-go/wp-content/plugins/flycart-reviews"
        ;;
    "wprelay")
        backend_dir="~/code/wordpress/affiliate-go/"
        react_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro/admin-ui"
        lazygit_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro"
        ;;
    "tremendous")
        backend_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous/"
        react_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous/tremendous-ui"
        lazygit_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous"
        ;;
    "paypal")
        backend_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/"
        react_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/paypal-ui"
        lazygit_dir="~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/"
        ;;
    *)
        echo "Unknown session name: $1"
        echo "Available options: review-plugin, wprelay, tremendous, paypal"
        exit 1
        ;;
esac

# Check if the session already exists
if tmux has-session -t $1 2>/dev/null; then
    echo "Session '$1' already exists. Attaching..."
else
    echo "Creating session '$1'..."
    create_tmux_session "$1" "$backend_dir" "$react_dir" "$lazygit_dir"
fi

# Attach to the session
tmux attach -t $1

