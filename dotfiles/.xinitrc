compton -b &
while true; do
hsetroot  -fill `find $HOME/pictures/wallpapers/ -type f|shuf -n1`
sleep 3600
done  &
xset s off &
xset -dpms &
xmodmap -e 'keycode 66 = F13' &
xmodmap -e 'clear Lock' & 
sleep 0.1 &&
sxhkd -r /dev/null &
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1 
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2 
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200 
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5 
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.95
dwm