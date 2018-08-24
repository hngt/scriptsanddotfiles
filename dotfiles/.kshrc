PS1='${PWD##*/}$(tput bold)[32m>[00m $(tput sgr0)'
alias data='date "+%d_%m_%Y_"'
alias no_blank='xset -dpms && xset s off'
alias ls='ls -b'
alias ll='ls -lhrat'
alias vi=vi
alias vim=vis
alias svi='sudo vis'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
export SUDO_ASKPASS=$HOME/bin/dpass
export HISTFILE=~/.ksh-history
export HISTSIZE=100
export LANG='en_US.utf8'
export LC_ALL=en_US.UTF-8
export EDITOR=vis
export NQDIR=/tmp/nq
mkdir -p /tmp/nq
export PAGER=most
export BROWSER=glinks
export PATH=$HOME/.local/bin:/usr/local/sbin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/bin:/usr/games:/opt/diet/bin:/usr/lib64/kde4/libexec:/usr/lib64/qt/bin:/usr/lib64/qt5/bin:/usr/share/texmf/bin:/sbin:/usr/sbin:$PATH
if [ "$(pgrep xinit)" ]
    then
    alias no_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 0"
    alias yes_touch="xinput set-prop `xinput | awk '/TouchPad/{print $6}' | sed -e 's/id=//'` \"Device Enabled\" 1"
fi
alias xready='no_touch && wmname LG3d'
alias mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS'
mkwebm()ffmpeg -i "$1" -c:v libvpx -b:v "$3" -c:a libvorbis "$2"
record()ffmpeg -video_size 1366x768 -framerate 60 -f x11grab -i :0.0+0,0 -f alsa -ac 2 -ar 44100 -i hw:Loopback,1,0 "$1"
case "$TERM" in
           xterm*) TERM=xterm-256color;
       esac 
[[ $(tty) = "/dev/tty1" ]] && exec startx
set -o emacs
