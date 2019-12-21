#!/bin/sh
compton -b &
xbanish &
xset s off &
xset -dpms &
sleep 0.1 &&
sxhkd -r /dev/null &
startplumb &
xmodmap ~/.Xmodmap &
toggletouchpad &
bspwm
