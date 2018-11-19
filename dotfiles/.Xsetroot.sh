#!/bin/dash

SOUND=`amixer get Master | grep -Eo '[0-9]{1,3}%'`
LOAD=`awk '{print $1" "$2" "$3}' /proc/loadavg`
ACPI=$(acpi | awk -vFS=', ' '/Discharging/{stat="-"} /Charging/{stat="+"} {print stat$2}' )
RAM_USAGE=`free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'`
DATE=`date +'%a %y/%m/%d %H:%M'`
MOC=`mocp -Q '%artist - %song'| awk '{print substr($0,1,50)}'`

# check if there are unread emails
UMSG=$(find $HOME/.mutt/mailbox/uni/inbox/new -type f | wc -l);
[ "$UMSG" != "0" ] && EMAILS_UNI="U: $UMSG | "
PMSG=$(find $HOME/.mutt/mailbox/personal/inbox/new -type f | wc -l);
[ "$PMSG" != "0" ] && EMAILS_PERSONAL="P: $PMSG | "
CMSG=$(find $HOME/.mutt/mailbox/cock/inbox/new -type f | wc -l);
[ "$CMSG" != "0" ] && EMAILS_COCK="C: $CMSG | "

# check if there are no old downloaded files so I do not keep them for too long
OLD_DOWN=$(find $HOME/downloads -type f -mmin +60 | wc -l);
[ "$OLD_DOWN" != "0" ] && OLD_FILES="Od: $OLD_DOWN | "

# battery check
if [ "$ACPI" = '-15%' ]; then
    sct 2000
elif [ "$ACPI" = '-10%' ]; then
    sct 1500
elif [ "$ACPI" = '-7%' ]; then
    sct 1000
elif [ "$ACPI" = '-5%' ]; then
    doas pm-hibernate
fi

xsetroot -name "${MOC} | ${OLD_FILES}${EMAILS_UNI}${EMAILS_PERSONAL}${EMAILS_COCK}${LOAD} | R:${RAM_USAGE} | V:${SOUND} | B:${ACPI} | ${DATE}"
