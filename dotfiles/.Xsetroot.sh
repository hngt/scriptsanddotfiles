#SOUND=`XDG_RUNTIME_DIR=/tmp/xdg-runtime-lich DISPLAY=:0 pamixer --get-volume`
SOUND=`amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]'`
LOAD=`uptime|grep -o '[0-9]\+\.[0-9][0-9]'|awk  -vRS= -vFS="\n" '{print  $1" "$2" "$3}'`
ACPI=`acpi|grep -o '[0-9]\+%'`
RAM_USAGE=`free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'`
DATE=`date +'%a %d %b %H:%M'`
#MPD=`mpc current|head -c40`
MOC=`mocp -Q "%artist - %song"|head -c40`
UMSG=$(find $HOME/.mutt/mailbox/uni/inbox/new -type f | wc -l);
[ "$UMSG" != "0" ] && EMAILS_UNI="U: $UMSG | "
PMSG=$(find $HOME/.mutt/mailbox/personal/inbox/new -type f | wc -l);
[ "$PMSG" != "0" ] && EMAILS_PERSONAL="P: $PMSG | "
CMSG=$(find $HOME/.mutt/mailbox/cock/inbox/new -type f | wc -l);
[ "$CMSG" != "0" ] && EMAILS_COCK="C: $CMSG | "
# battery check
#if [ "$ACPI" = '15%' ]; then
#    aplay /home/lich/music/samples/synth/synth-nattegeit.wav
#elif [ "$ACPI" = '10%' ]; then
#    aplay /home/lich/music/samples/moje/micheljordan.wav
#elif [ "$ACPI" = '7%' ]; then
#    sct 1000
#elif [ "$ACPI" = '5%' ]; then
#    sudo ZZZ
#fi

#xsetroot -name "${MPD} | ${LOAD} | ${RAM_USAGE} | ${SOUND}% | VPN:${VPN} | ${ACPI} | ${DATE}"
xsetroot -name "${MOC} | ${EMAILS_UNI}${EMAILS_PERSONAL}${EMAILS_COCK}${LOAD} | R:${RAM_USAGE} | V:${SOUND} | B:${ACPI} | ${DATE}"
