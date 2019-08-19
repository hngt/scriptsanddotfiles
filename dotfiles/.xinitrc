#!/bin/sh
compton -b &
hsetroot  -tile $HOME/pictures/wallpapers/tiling/tile2.png &
xbanish &
xset s off &
xset -dpms &
xmodmap -e 'keycode 66 = F13' &
xmodmap -e 'clear Lock' & 
sleep 0.1 &&
sxhkd -r /dev/null &
startplumb &
while true; do
slstatus
done &
a &
st &
exec dwm
