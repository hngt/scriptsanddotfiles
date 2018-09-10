alias no_blank='xset -dpms && xset s off'
alias ls='ls -b'
alias ll='ls -blhrat'
alias vi=vi
alias vim=vis
alias svi='doas vis'
alias xready='no_touch && wmname LG3d'
alias mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS'
. $HOME/.private-commands 
if [ "$(pgrep xinit)" ]
    then
    alias no_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 0"
    alias yes_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 1"
fi
set -o emacs
mkwebm()ffmpeg -i "$1" -c:v libvpx -b:v "$3" -c:a libvorbis "$2";
record()ffmpeg -video_size 1366x768 -framerate 60 -f x11grab -i :0.0+0,0 -f alsa -ac 2 -ar 44100 -i hw:Loopback,1,0 "$1";
case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac
[[ $(tty) = "/dev/tty1" ]] && exec startx
export PS1='${PWD##*/}$(tput bold)[32m>[00m $(tput sgr0)'
