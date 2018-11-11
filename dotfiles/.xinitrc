compton -b &
while true; do
hsetroot  -fill "$(find $HOME/pictures/wallpapers/ -type f|shuf -n1)"
sleep 3600
done  &
xset s off &
xset -dpms &
xmodmap -e 'keycode 66 = F13' &
xmodmap -e 'clear Lock' & 
sleep 0.1 &&
sxhkd -r /dev/null &
startplumb &
dwm