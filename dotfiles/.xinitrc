#!/bin/sh
compton -b &
xbanish &
xset s off &
xset -dpms &
sleep 0.1 &&
sxhkd -r /dev/null &
startplumb &
setroot &
a &
st &
toggletouchpad &
workrave &
