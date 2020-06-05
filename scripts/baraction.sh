#!/bin/sh
panelfifo=/tmp/panel
rm -f $panelfifo
mkfifo $panelfifo

corona(){
	while true; do
		coronafile="$HOME/.cache/corona"
		[ "$(stat --format="%y" "$coronafile" 2>/dev/null | cut -d ' ' -f1)" != "$(date +%F)" ] && 
			curl -s "https://coronavirus-tracker-api.herokuapp.com/v2/locations?country_code=PL" > "$coronafile"
		jq -j '.latest|"cC:",.confirmed," D:",.deaths,"\n"' ~/.cache/corona
		sleep 3600
	done
}

sound(){
	while true; do
		volume="$(amixer get Master | grep -Eo '[0-9]{1,3}%')"
		echo "V$volume"
		sleep 1
	done
}

load_avg(){
	while true; do
		awk '{print "L"$1" "$2" "$3}' /proc/loadavg
		sleep 1
	done
	}

bttry(){
	while true; do
		battery="$(acpi | awk -vFS=', ' '/Discharging/{stat="-"} /Charging/{stat="+"} {print stat$2}' )"
		case "$battery" in
			-15%) sct 2000 > /dev/null ;;
			-10%) sct 1500 > /dev/null ;;
			-7%)  sct 1000 > /dev/null ;;
			-5%)  doas pm-hibernate    ;;
		esac
		echo "B$battery"
		sleep 5
	done

}

memory(){
	while true; do
		free | awk '/Mem/{printf("R%.2f%%\n", $3/$2 * 100.0)}'
		sleep 2
	done
	}

curdate(){
	while true; do
		date "+D%A %d.%m.%y %H:%M"
		sleep 2
	done
}

mails(){
	while sleep 2; do
		emails=""
		for i; do
			mailcount="$(ls -1 "$HOME/.mutt/mailbox/$i/inbox/new" | wc -l)"
			[ "$mailcount" != "0" ] && emails=$emails"$i-$mailcount"
		done
		[ "$emails" != "" ] && echo "m$emails" || echo m0
	done
}

bargen(){
	pad=" | "
	while read -r line; do
		case $line in
			c*) corona="${line#?}";;
			C0) countdown="";;
			C*) countdown="${line#?}$pad";;
			B*) battery="B:${line#?}";;
			D*) cal="${line#?}";;
			L*) load="${line#?}";;
			m0) mails="";;
			m*) mails="M:${line#?}$pad";;
			R*) ram="R:${line#?}";;
			V*) volume="V:${line#?}";;
			X*) mus="${line#?}";;
			esac
	echo "${mus}${pad}${mails}${countdown}${load}${pad}${corona}${pad}${ram}${pad}${volume}${pad}${battery}${pad}${cal}"
	done
}
corona > $panelfifo &
sound > $panelfifo &
load_avg > $panelfifo &
bttry > $panelfifo &
memory > $panelfifo &
curdate > $panelfifo &
mails uni personal dataswamp cock > $panelfifo &

bargen < $panelfifo