export PS1='${?#0}\W\T\$ '
alias em='doas emerge --color n' \
	e='$EDITOR' \
	eix='eix -n' \
	g='git' \
	i='irssi' \
	ll='ls -Flrt' \
	ls='ls -F' \
	m='mutt' \
	mkd='mkdir -pv' \
	mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS' \
	mkpdf='libreoffice --headless --convert-to pdf' \
	no_blank='xset -dpms && xset s off' \
	nvi='sam -d' \
	o='mocp' \
	off='doas poweroff' \
	p='zathura' \
	rcs='doas /sbin/rc-service' \
	svi='doas sam -d' \
	s='sfeed_update && tscrape_update && torsocks mbsync -a' \
	t='tmux' \
	trem='transmission-remote' \
	v="mpv" \
	vi='sam -d' \
	vim='sam -d' \
	vis='cat' \
	yt='youtube-dl --add-metadata -ic' \
	yta='yt -x -f bestaudio/best --ignore-config --add-metadata' \
	x='sxiv -ft *' \
	xvga='xrandr --output VGA-1 --primary'

. $HOME/.ksh_completion
. $HOME/.private-commands

set -o emacs
bind -m '^L'='^U'clear'^J''^Y'

mkwebm() { ffmpeg -i "$1" -c:v libvpx -b:v "$3" -c:a libvorbis "$2"; }
file0() { curl -sL -F files[]=@"$1" https://file0.s3kr.it/upload | sed -n 's@.*https*://file0.s3kr.it/@https://file0.s3kr.it/@;s@'\'')">@@p'; }
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}

case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac
