# For aliases that are machine specific
if [ -f $HOME/.extend.sh ]; then
    source $HOME/.extend.sh
fi

# Default fzf command
export FZF_DEFAULT_COMMAND="find ~/ -type f"

# Shell history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_DATA_HOME/zsh/history

# Shell compdump
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Vi Mode
bindkey -v
export KEYTIMEOUT=1

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# VCS Info
autoload -Uz vcs_info
precmd() { vcs_info }

## Keybinds

# History search traversal
bindkey '^R' history-incremental-pattern-search-backward

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Plugins
ZSH_PLUGINS_DIR="$XDG_CONFIG_HOME/zsh/plugins"

if [ ! -d $ZSH_PLUGINS_DIR ]; then
    echo "Missing shell plugins, installing..."

    mkdir $ZSH_PLUGINS_DIR

    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
        $ZSH_PLUGINS_DIR/zsh-autosuggestions
    git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting \
        $ZSH_PLUGINS_DIR/zsh-syntax-highlighting

    echo "Plugin installation complete!"
fi

source $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# TPM (tmux plugin manager)

TMUX_PLUGINS_DIR="$XDG_CONFIG_HOME/tmux/plugins"

if [ ! -d $TMUX_PLUGINS_DIR ]; then
    echo "Missing TPM (tmux plugin manager), installing..."

    mkdir $TMUX_PLUGINS_DIR
    git clone --quiet https://github.com/tmux-plugins/tpm $TMUX_PLUGINS_DIR/tpm

    echo "TPM (tmux plugin manager) installation complete!"
fi

# Xresources
if [ ! -f "$HOME/.Xresources" ]; then
    echo "Missing Xresources, installing..."

    curl https://raw.githubusercontent.com/dracula/xresources/master/Xresources \
        -o $HOME/.Xresources
    
    echo "Xresources installation complete!"
fi

# Plugin Options
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"

# Custom User Functions
ef() { 
    [ -n "$1" ] && $EDITOR "$(find $1 -type f | fzf)" || 
    $EDITOR "$(find $HOME/.config -type f | fzf)"
}

# Alias Configuration
alias ls="eza --icons"
alias ll="eza -lg --header --icons"
alias la="eza -a --icons"
alias lla="eza -lga --header --icons"
alias cat="bat --theme Dracula"
alias transmit="transmission-remote"
alias ping="prettyping"
alias vim="nvim"
alias k="kubectl"
alias d="docker"
alias s="source $HOME/.config/zsh/.zshrc"
alias lock="systemctl suspend"

# Initialize shell prompt
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "x"
zstyle ':vcs_info:git:*' formats '(%F{magenta}%b%f) %F{red}%u%f%F{green}%c%f '
zstyle ':vcs_info:git:*' actionformats '(%F{magenta}%b|%a%f) %F{red}%u%f%F{green}%c%f '
setopt PROMPT_SUBST

SHELL_START_STRING="%F{#b18ef9}|>%f"
SHELL_DIR="%F{cyan}%1~%f"
SHELL_END_STRING="%B%(?.%F{green}↪%f.%F{red}↪%f)%b"

PROMPT='${SHELL_START_STRING} ${SHELL_DIR} ${vcs_info_msg_0_}${SHELL_END_STRING} '

# Tmux autostart
if [ -z "${TMUX}" ]; then
    exec tmux new -A -s lain >/dev/null 2>&1
fi
