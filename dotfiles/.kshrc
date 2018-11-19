export PS1='${PWD##*/}\$ '
alias no_blank='xset -dpms && xset s off'
alias ls='ls -b'
alias ll='ls -blhrat'
alias vi=vi
alias vim=vis
alias svi='doas vis'
alias mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS'
alias trem='transmission-remote'
alias g='git'
alias e='doas emerge --color n'
alias mkd='mkdir -pv'
alias yt='youtube-dl --add-metadata -ic'
alias yta='yt -x -f bestaudio/best'
alias rcs='doas /sbin/rc-service'
alias eix='eix -n'

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

case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac

[[ $(tty) = "/dev/tty1" ]] && exec startx