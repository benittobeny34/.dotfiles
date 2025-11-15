#!/bin/bash

# Install script: Installs required packages and sets up the environment

# Check for Homebrew, install if not found
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found, installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Ensure brew is immediately available after installation
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew to ensure latest versions
brew update

# Install zsh
brew install zsh

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Zsh plugins
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install zsh-completions

# Make zsh the default shell if it’s not already
if [ "$SHELL" != "/usr/local/bin/zsh" ]; then
    echo "Setting zsh as the default shell..."
    chsh -s "$(which zsh)"
fi

# Install other utilities
brew install fzf
brew install tmux
brew install neovim
brew install stow
brew install --cask iterm2
brew install ripgrep
brew install bat
brew install git

# Install dependencies
brew install go        # Install Go
brew install node      # Install Node.js
brew install lazygit   # Install Lazygit
brew install spellcheck # Install Spellcheck
brew install composer #install composer

# Use stow to manage dotfiles if directories are prepared
if [ -d "$HOME/.dotfiles" ]; then
    cd "$HOME/.dotfiles" || exit
    stow git
    stow nvim
    stow tmux
    stow zsh
fi

echo "Installation complete. Please restart your terminal to apply changes."

