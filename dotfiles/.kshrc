export PS1='${PWD##*/}\$ '
alias em='doas emerge --color n'
alias e='$EDITOR'
alias eix='eix -n'
alias g='git'
alias ll='ls -Flrt'
alias ls='ls -F'
alias mkd='mkdir -pv'
alias mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS'
alias no_blank='xset -dpms && xset s off'
alias rcs='doas /sbin/rc-service'
alias svi='doas sam -d'
alias trem='transmission-remote'
alias vi='sam -d'
alias vim='sam -d'
alias vis='cat'
alias yt='youtube-dl --add-metadata -ic'
alias yta='yt -x -f bestaudio/best'

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
record()ffmpeg -video_size 1366x768 -framerate 60 -f x11grab -i :0.0+0,0 -f alsa -ac 2 -ar 44100 -i hw:Loopback,1,0 "$1";
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}
khdl() { curl -s "$@" | sed -nE 's;.*href="(/game.*.mp3)">.*;https://downloads.khinsider.com\1;p' | xe -s 'curl -O $(curl -s $0 | grep -o "http.*mp3" | uniq) ' && for i in *mp3; do mv "$i" $(echo \"$i\" | sed -E 's/(%20){1,}/_/g'); done; }

case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac

[[ $(tty) = "/dev/tty1" ]] && exec startx
