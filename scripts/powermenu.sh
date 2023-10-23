#! /usr/bin/sh

declare -A opts

opts=(
    [襤 Poweroff  ]="poweroff"
    [累 Reboot]="reboot"
    [ Logout]="bspc quit"
    [ Lock]="betterlockscreen --text 'Hiya chief ^_^' -l"
    [Sleep]="systemctl suspend"
)

choice=$(printf "%s\n" "${!opts[@]}" | dmenu)

eval ${opts[$choice]}
