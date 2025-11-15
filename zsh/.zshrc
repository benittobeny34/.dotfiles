# --- Powerlevel10k instant prompt ---
# Should stay close to the top of ~/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
plugins=(zsh-autosuggestions wp-cli)
source $ZSH/oh-my-zsh.sh

# --- PATH ---
export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/nvim-macos-x86_64/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/bin:/opt/homebrew/opt/php@7.4/sbin:$PATH"

# --- Powerlevel10k theme ---
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Editor ---
export EDITOR=nvim

# --- Load environment variables safely (after instant prompt) ---
[[ -f ~/.dotfiles/.env ]] && export $(grep -v '^#' ~/.dotfiles/.env | xargs)

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- fzf & bat integrations ---
if command -v fzf >/dev/null 2>&1; then
    if command -v bat >/dev/null 2>&1; then
        alias fzf="fzf --preview 'bat --color=always --style=header,grid --line-range :500 {}'"
    fi
    alias fdr='cd "$(find . -type d \( -path "*/.git" -o -name "node_modules" -o -name "vendor" -o -name ".idea" -o -name ".next" \) -prune -o \( -type d ! -name ".*" \) -print | fzf)"'
    alias fdc='cd ~/code && cd "$(find . -type d \( -path "*/.git" -o -name "node_modules" -o -name "vendor" -o -name ".idea" -o -name ".next" \) -prune -o \( -type d ! -name ".*" \) -print | fzf)"'
    source <(fzf --zsh)
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
fi

# --- lazygit ---
if command -v lazygit >/dev/null 2>&1; then
    alias g="lazygit"
fi

# --- Aliases ---
alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
alias home="cd $HOME"
alias ct="bash $HOME/.dotfiles/scripts/ct.sh"
alias dotfiles='cd $HOME/.dotfiles && nv .'
alias f='fzf | pbcopy'
alias gr='go run main.go'
alias ben="tmuxifier load-session"

# --- tmuxifier ---
eval "$(tmuxifier init -)"
if ! tmux ls &>/dev/null; then
    tmux start-server
fi

# --- Functions ---
open-at-line() {
    nv $(rg --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print "+"$2" "$1}')
}

# --- Key bindings ---
bindkey -v
bindkey -M vicmd '/' vi-history-search-backward
bindkey -M vicmd '?' vi-history-search-forward

function zle-keymap-select {
  case $KEYMAP in
    vicmd) MODE_INDICATOR="%F{blue}[NORMAL]%f" ;;
    viins|main) MODE_INDICATOR="%F{green}[INSERT]%f" ;;
  esac
  zle reset-prompt
}
zle -N zle-keymap-select
precmd() { MODE_INDICATOR="%F{yellow}[CMD]%f" }
PROMPT='${MODE_INDICATOR} %F{cyan}%~%f %# '



# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/benittoraj42/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP binary.
export PATH="/Users/benittoraj42/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="/Users/benittoraj42/Library/Application Support/Herd/config/php/74/"
