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

# brew install zsh-syntax-highlighting
if [[ "$OSTYPE" == "darwin"* ]]; then # macOS
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

