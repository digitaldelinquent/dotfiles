#! /usr/bin/sh

declare -A opts

opts=(
    [襤 Poweroff  ]="poweroff"
    [累 Reboot]="reboot"
    [ Logout]="bspc quit"
    [ Lock]="i3lock -i $HOME/Pictures/lain.png; systemctl suspend"
)

choice=$(printf "%s\n" "${!opts[@]}" | dmenu -nb "#282A36" -nf "#ffffff" -sb "#b18ef9" -sf "#ffffff" -fn monospace -b)

eval ${opts[$choice]}
