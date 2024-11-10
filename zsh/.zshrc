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
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/cartrabbit/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ben="bash /Users/cartrabbit/.tmux/create-sessions.sh"
