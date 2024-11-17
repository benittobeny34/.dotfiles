#!/bin/bash

# Function to create a tmux session with windows and set directory for each window
create_tmux_session() {
    local session_name=$1
    local backend_dir=$2
    local lazygit_dir=$3
    local react_dir=${4:-} # Default to empty if not provided

    # Expand '~' to the full path
    backend_dir=$(eval echo $backend_dir)
    lazygit_dir=$(eval echo $lazygit_dir)
    react_dir=$(eval echo $react_dir)

    # Create the session and first window
    tmux new-session -d -s $session_name -n "backend" -c $backend_dir
    tmux send-keys -t $session_name:0 "echo 'Working in $backend_dir'" C-m

    # Create the React window (window 1) only if a React directory is specified
    if [ -n "$react_dir" ]; then
        tmux new-window -t $session_name:1 -n "react" -c $react_dir
        tmux send-keys -t $session_name:1 "echo 'Working in $react_dir'" C-m
    fi

    # Create the Lazygit window (window 2 or 1 if React is missing)
    local lazygit_window_index=1
    if [ -n "$react_dir" ]; then
        lazygit_window_index=2
    fi
    tmux new-window -t $session_name:$lazygit_window_index -n "lazygit" -c $lazygit_dir
    tmux send-keys -t $session_name:$lazygit_window_index "lazygit" C-m
}

# Check for session name argument
if [ -z "$1" ]; then
    echo "Please specify a session name: Available options: review-plugin, wprelay, tremendous, paypal, loyalty-points, dotfiles"
    exit 1
fi

# Determine directories based on the session name
case $1 in
    "review-plugin")
        create_tmux_session "review-plugin" \
            "~/code/wordpress/affiliate-go/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/flycart-reviews" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/flycart-reviews/admin-ui"
        ;;
    "wprelay")
        create_tmux_session "wprelay" \
            "~/code/wordpress/affiliate-go/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro/admin-ui"
        ;;
    "tremendous")
        create_tmux_session "tremendous" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-tremendous/tremendous-ui"
        ;;
    "paypal")
        create_tmux_session "paypal" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-paypal/paypal-ui"
        ;;
    "loyalty-points")
        create_tmux_session "loyalty-points" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-loyalty-points/" \
            "~/code/wordpress/affiliate-go/wp-content/plugins/wprelay-loyalty-points/" \
        ;;
    "dotfiles")
        # Pass only backend and lazygit directories, leaving React as optional
        create_tmux_session "dotfiles" \
            "~/.dotfiles/" \
            "~/.dotfiles/"
        ;;
    *)
        echo "Unknown session name: $1"
        echo "Available options: review-plugin, wprelay, tremendous, paypal, loyalty-points, dotfiles"
        exit 1
        ;;
esac

# Check if the session already exists
if tmux has-session -t $1 2>/dev/null; then
    echo "Session '$1' already exists. Attaching..."
else
    echo "Creating session '$1'..."
fi

# Attach to the session
tmux attach -t $1

