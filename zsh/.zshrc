# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    # other plugins...
    zsh-autosuggestions
    wp-cli
)

export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/nvim-macos-x86_64/bin
source ~/powerlevel10k/powerlevel10k.zsh-theme


if command -v fzf >/dev/null 2>&1; then
    if command -v bat >/dev/null 2>&1; then        
        alias fzf="fzf --preview 'bat --color=always --style=header,grid --line-range :500 {}'"
    fi
    #find directory in the current directory without hidden directories
    alias fdr='cd "$(find . -type d \( -path "*/.git" -o -name "node_modules" -o -name "vendor" -o -name ".idea" -o -name ".next" \) -prune -o \( -type d ! -name ".*" \) -print | fzf)"'
    alias fdc='cd ~/code && cd "$(find . -type d \( -path "*/.git" -o -name "node_modules" -o -name "vendor" -o -name ".idea" -o -name ".next" \) -prune -o \( -type d ! -name ".*" \) -print | fzf)"'
    #CTRL+R for recent history list
    source <(fzf --zsh)
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
fi

if command -v lazygit >/dev/null 2>&1; then
    alias g="lazygit"
fi

alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
alias home="cd $HOME"
alias ct="bash $HOME/.dotfiles/scripts/ct.sh"
alias dotfiles='cd $HOME/.dotfiles && nv .'
alias f='fzf | pbcopy'
alias gr='go run main.go'

#tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if ! tmux ls &>/dev/null; then
    tmux start-server
fi

open-at-line() {
    nv $(rg --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print "+"$2" "$1}')
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/cartrabbit/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ben="tmuxifier load-session"
export PATH="/Users/cartrabbit/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/cartrabbit/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

export EDITOR=nvim

export $(grep -v '^#' ~/.dotfiles/.env | xargs)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

bindkey -v
# Bind '/' to history search (like Vim's /)

bindkey -M vicmd '/' vi-history-search-backward
bindkey -M vicmd '?' vi-history-search-forward

# function zle-keymap-select {
#   if [[ $KEYMAP == vicmd ]]; then
#     echo -ne "\033]0;-- NORMAL --\007"
#   else
#     echo -ne "\033]0;\007"
#   fi
# }
# zle -N zle-keymap-select

function zle-keymap-select {
  case $KEYMAP in
    vicmd) MODE_INDICATOR="%F{blue}[NORMAL]%f" ;;
    viins|main) MODE_INDICATOR="%F{green}[INSERT]%f" ;;
  esac
  zle reset-prompt
}
zle -N zle-keymap-select

precmd() { MODE_INDICATOR="%F{yellow}[CMD]%f" }

# Add the indicator to your prompt
PROMPT='${MODE_INDICATOR} %F{cyan}%~%f %# '


