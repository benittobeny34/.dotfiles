session_root "$HOME/code/wordpress/affiliate-go/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name
if initialize_session "wprelay"; then
  # Create a new window inline within session layout definition.
  new_window "temp"
  run_cmd "tmux source $HOME/.tmux/.tmux.conf"

  # Create a new window inline within session layout definition.
  new_window "backend"
  run_cmd "cd $HOME/code/wordpress/affiliate-go/"

  # Create another window with a custom directory
  new_window "frontend" 
  run_cmd "cd $HOME/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro/admin-ui/"
  split_v 10
  run_cmd "cd $HOME/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro/admin-ui/"
  run_cmd "npm run dev"
  select_pane 0

  # Create another window with a custom directory
  new_window "lazygit" 
  run_cmd "cd $HOME/code/wordpress/affiliate-go/wp-content/plugins/wprelay-pro/"

  
  tmux kill-window -t temp
  # Select the default active window on session creation.
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
