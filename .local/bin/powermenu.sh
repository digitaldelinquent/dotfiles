#! /usr/bin/env sh

declare -A opts

opts=(
    [襤 Poweroff  ]="poweroff"
    [累 Reboot]="reboot"
    [ Logout]="bspc quit"
    [ Lock]="i3lock -i $HOME/Media/Wallpapers/lain.png; systemctl suspend"
)

choice=$(printf "%s\n" "${!opts[@]}" | rofi -dmenu -p "Power")

eval ${opts[$choice]}
