compton -b &
sxhkd -r /dev/null &
while true; do
hsetroot -cover `find /home/lich/Pictures/Wallpapers/ -type f|shuf -n1`
sleep 600
done  &
xset s off &
xset -dpms &
workrave &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session dwm
