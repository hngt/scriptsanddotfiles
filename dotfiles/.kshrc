export PS1='${?#0}\W\T\$ '
alias em='doas emerge --color n' \
	e='$EDITOR' \
	eix='eix -n' \
	g='git' \
	ll='ls -Flrt' \
	ls='ls -F' \
	mkd='mkdir -pv' \
	mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS' \
	mpv="mpv --input-ipc-server=/tmp/mpvsoc$(date +%s)" \
	no_blank='xset -dpms && xset s off' \
	rcs='doas /sbin/rc-service' \
	svi='doas sam -d' \
	trem='transmission-remote' \
	vi='sam -d' \
	vim='sam -d' \
	vis='cat' \
	yt='youtube-dl --add-metadata -ic' \
	yta='yt -x -f bestaudio/best' \
	x='sxiv -ft *'

. $HOME/.ksh_completion
. $HOME/.private-commands
 
if [ "$(pgrep xinit)" ]
    then
    alias no_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 0"
    alias yes_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 1"
fi

set -o emacs
bind -m '^L'='^U'clear'^J''^Y'

mkwebm()ffmpeg -i "$1" -c:v libvpx -b:v "$3" -c:a libvorbis "$2";
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}

case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac

[[ $(tty) = "/dev/tty1" ]] && exec startx
clear
