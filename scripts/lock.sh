#! /usr/bin/sh

killall -q xautolock
killall -q xidlehook

while pgrep xautolock && pgrep xidlehook
do
    sleep 0.01s
done

exec xautolock -detectsleep -time 15 \
    -locker "$HOME/.local/bin/betterlockscreen --text 'Hiya chief ^_^' -l" \
    -notify 30 -notifier "notify-send -u critical -t 10000 -- 'Screen locking in 30 seconds'" &

exec xidlehook --not-when-fullscreen --timer 1200 "suspend" - &
