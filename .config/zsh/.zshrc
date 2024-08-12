# Just in case
source $HOME/.zprofile

# For aliases that are machine specific
if [ -f $HOME/.extend ]; then
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

# Plugins
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# Plugin Options
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"

# Custom User Functions
ef() { 
    [ -n "$1" ] && $EDITOR "$(find $1 -type f | fzf)" || 
    $EDITOR "$(find $HOME/.config -type f | fzf)"
}

# Reinstall roelm packages
reinstall() {
    sudo dnf install $(cat $HOME/.dotfiles/packages);
    return 1
}

# User Configuration
# alias suspend="systemctl suspend"
alias ls="exa --icons"
alias ll="exa -lg --header --icons"
alias la="exa -a --icons"
alias lla="exa -lga --header --icons"
alias cat="bat --theme Dracula"
alias transmit="transmission-remote"
alias feh="devour feh -. --no-fehbg"
alias mpv="devour mpv"
alias mupdf="devour mupdf"
alias ping="prettyping"
alias vim="nvim"
alias ovsctl="ovs-vsctl"
alias parrot="sudo docker run --rm -ti -e DISPLAY=$DISPLAY --network host -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/parrotos/:/persistent -v $HOME/.Xauthority:/root/.Xauthority parrotsec/security"
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"
neofetch
eval "$(starship init zsh)"
export QT_QPA_PLATFORMTHEME="gtk2"
export DBX_CONTAINER_MANAGER="podman"

# Tmux autostart
if [ -z "${TMUX}" ]; then
    exec tmux new -A -s lain >/dev/null 2>&1
fi
