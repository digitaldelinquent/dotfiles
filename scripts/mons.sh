#! /usr/bin/sh

MONS=($(xrandr -q | grep " connected" | cut -d ' ' -f1))


[ ${#MONS[*]} -gt 1 ] &&
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --set TearFree on \
--auto --output eDP1 --mode 1920x1080 --set TearFree on --auto --right-of HDMI-A-0 ||
xrandr --output eDP1 --primary --mode 1920x1080 --set TearFree on --auto \
--output HDMI-A-0 --off

for i in ${MONS[*]}
do
    bspc monitor $i -d 1 2 3 4
done
