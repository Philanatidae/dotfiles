alias lg=lazygit

export PROMPT='%F{208}(%n)%f %F{226}%~%f$ '
export EDITOR="nvim"
export VISUAL="$EDITOR"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=5000
export HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Potential: change keybindings to vim-style
# bindkey -v

# zsh-syntax-highlighting
if [[ "$OSTYPE" == darwin* ]]; then
    zsh_hl=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    [[ -r $zsh_hl ]] || zsh_hl=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    zsh_hl_install="brew install zsh-syntax-highlighting"
elif [[ "$OSTYPE" == linux* ]] && grep -qi '^ID=.*fedora' /etc/os-release 2>/dev/null; then
    zsh_hl=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    zsh_hl_install="sudo dnf install -y zsh-syntax-highlighting"
fi

if [[ -r $zsh_hl ]]; then
    source $zsh_hl
elif [[ -n $zsh_hl_install ]] && [[ -o interactive ]]; then
    if read -q "?zsh-syntax-highlighting not found. Install with '$zsh_hl_install'? [y/N] "; then
        echo
        eval $zsh_hl_install && source $zsh_hl
    fi
    echo
fi
unset zsh_hl zsh_hl_install

if [[ "$OSTYPE" != darwin* ]]; then
    alias task=go-task
fi
