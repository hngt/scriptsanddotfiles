#!/bin/sh
compton -b &
xbanish &
xset s off &
xset -dpms &
sleep 0.1 &&
startplumb &
xmodmap ~/.Xmodmap &
toggletouchpad &
bspwm
