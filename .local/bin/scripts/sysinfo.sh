#! /usr/bin/zsh

echo "$(date +"Date: %A %d %B %Y%nTime: %r")\nBattery: $(grep "POWER_SUPPLY_CAPACITY=" /sys/class/power_supply/BAT0/uevent | sed "s/POWER_SUPPLY_CAPACITY=//g")%" | xargs -d "\r" notify-send
