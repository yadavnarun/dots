#!/usr/bin/env sh

# Terminate already running bar instances
ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs kill
killall -q polybar

# Launch all bars
polybar -c ~/.config/polybar/config.ini main &
# polybar -c ~/.config/polybar/config.ini sub & 

# sleep 2
# hideIt.sh --name '^polybar-sub_eDP$' -p 3 -d top -H -s 3 &
