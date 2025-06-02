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

ZSH_PLUGINS_DIR='~/.config/zsh/plugins'
ZSH_HIGHLIGHTING_REPO='$ZSH_PLUGINS_DIR/zsh-syntax-highlighting'
ZSH_AUTO_SUGGESTONS_REPO='$ZSH_PLUGINS_DIR/zsh-autosuggestions'

# Plugins
if [ ! -d $ZSH_HIGHLIGHTING_REPO || ! -d $ZSH_AUTO_SUGGESTONS_REPO ]; then
    mkdir -p $ZSH_PLUGINS_DIR

    git clone https://github.com/zsh-users/zsh-autosuggestions:plugins/zsh-autosuggestions \
        $ZSH_HIGHLIGHTING_REPO
    git clone https://github.com/zsh-users/zsh-syntax-highlighting:plugins/zsh-syntax-highlighting \
        $ZSH_AUTO_SUGGESTONS_REPO
fi

source $ZSH_HIGHLIGHTING_REPO/zsh-syntax-highlighting.zsh 2>/dev/null
source $ZSH_AUTO_SUGGESTONS_REPO/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# Plugin Options
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"

# Custom User Functions
ef() { 
    [ -n "$1" ] && $EDITOR "$(find $1 -type f | fzf)" || 
    $EDITOR "$(find $HOME/.config -type f | fzf)"
}

# User Configuration
alias ls="eza --icons"
alias ll="eza -lg --header --icons"
alias la="eza -a --icons"
alias lla="eza -lga --header --icons"
alias cat="bat --theme Dracula"
alias transmit="transmission-remote"
alias ping="prettyping"
alias vim="nvim"
alias remote-nix="NIX_SSHOPTS='-o RequestTTY=force' nixos-rebuild --target-host admin@192.168.1.241 --use-remote-sudo switch --flake .#homelab"
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"

# System command aliases
alias lock="systemctl suspend"
alias reload="sudo nixos-rebuild switch --flake .#comp22"
alias upgrade="sudo nixos-rebuild switch --flake .#comp22 --upgrade"
alias dump="sudo nix-collect-garbage -d"

# Initialize shell prompt
fastfetch
eval "$(starship init zsh)"

# Tmux autostart
if [ -z "${TMUX}" ]; then
    exec tmux new -A -s lain >/dev/null 2>&1
fi
