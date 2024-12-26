# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "$HOME/code/laravel/review-sass/backend/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "yuko"; then
  # Create a new window inline within session layout definition.
  new_window "temp"
  run_cmd "tmux source $HOME/.tmux/.tmux.conf"

  # Create a new window inline within session layout definition.
  new_window "backend"
  run_cmd "cd $HOME/code/laravel/review-sass/backend"
  split_v 10
  run_cmd "docker exec -it laravel_app bash"
  select_pane 0
  run_cmd "git branch --show-current"

  # Create another window with a custom directory
  new_window "frontend" 
  run_cmd "cd $HOME/code/laravel/review-sass/frontend"
  split_v 10
  run_cmd "docker exec -it react_app bash"
  run_cmd "npm run dev"
  select_pane 0
  run_cmd "git branch --show-current"

  # Create another window with a custom directory
  new_window "wordpress" 
  run_cmd "cd $HOME/code/wordpress/affiliate-go/"
  split_v 10
  run_cmd "cd $HOME/code/wordpress/affiliate-go/wp-content/plugins/yuko-integration/"



  
  tmux kill-window -t temp
  # Select the default active window on session creation.
  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
