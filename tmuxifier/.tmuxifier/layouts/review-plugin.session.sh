session_root "$HOME/code/laravel/review-sass/wordpress/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "review-plugin"; then
  # Create a new window inline within session layout definition.
  new_window "temp"
  run_cmd "tmux source $HOME/.tmux/.tmux.conf"

  # Create a new window inline within session layout definition.
  new_window "backend"
  run_cmd "cd $HOME/code/laravel/review-sass/wordpress/"

  # Create another window with a custom directory
  new_window "frontend" 
  run_cmd "cd $HOME/code/laravel/review-sass/wordpress/wp-content/plugins/flycart-reviews/admin-ui/"
  split_v 10
  run_cmd "cd $HOME/code/laravel/review-sass/wordpress/wp-content/plugins/flycart-reviews/admin-ui/"
  run_cmd "npm run dev"
  select_pane 0

  # Create another window with a custom directory
  new_window "lazygit" 
  run_cmd "cd $HOME/code/laravel/review-sass/wordpress/wp-content/plugins/flycart-reviews/"

  
  tmux kill-window -t temp
  # Select the default active window on session creation.
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
