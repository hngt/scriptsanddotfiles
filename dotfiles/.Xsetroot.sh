DISPLAY=:0
#SOUND=`XDG_RUNTIME_DIR=/tmp/xdg-runtime-lich DISPLAY=:0 pamixer --get-volume`
SOUND=`amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]'`
LOAD=`uptime|grep -o '[0-9]\+\.[0-9][0-9]'|awk  -vRS= -vFS="\n" '{print  $1" "$2" "$3}'`
ACPI=`acpi|grep -o '[0-9]\+%'`
RAM_USAGE=`free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'`
DATE=`date +'%a %d %b %H:%M'`
#MPD=`mpc current|head -c40`
MOC=`mocp -Q "%artist - %song"|head -c40`
echo ${ACPI}
#xsetroot -name "${MPD} | ${LOAD} | ${RAM_USAGE} | ${SOUND}% | VPN:${VPN} | ${ACPI} | ${DATE}"
xsetroot -name "${MOC} | ${LOAD} | R:${RAM_USAGE} | V:${SOUND} | B:${ACPI} | ${DATE}"
