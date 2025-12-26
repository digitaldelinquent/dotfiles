#!/usr/bin/env bash

battery_level=$(grep "POWER_SUPPLY_CAPACITY=" /sys/class/power_supply/BAT1/uevent | sed "s/POWER_SUPPLY_CAPACITY=//g")

if [ $battery_level -le 15 ]; then
    notify-send -a "Low Battery" "WARNING: Battery charge is low ($battery_level%)"
fi
