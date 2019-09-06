BROWSER=glinks
EDITOR=mg
ENV=$HOME/.kshrc
font='/mnt/font/Go Mono/11a/font'
GOPATH=$HOME/go
GOBIN=$GOPATH/bin
GS_FONTPATH=/usr/share/fonts
HISTFILE=$HOME/.ksh-history
HISTSIZE=100
LANG='en_US.utf8'
LC_ALL=en_US.UTF-8
NNN_BMS='v:~/videos;m:~/music;u:~/university'
NNN_OPENER=plumb
PAGER=less
PATH=$HOME/bin/games:$HOME/bin/jre:$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH
PLAN9=/usr/lib/plan9
PLUMBER=plumb
READER=zathura
REFER=$HOME/.bibliography
WINEDEBUG='-all'
GPG_TTY=$(tty)
XDG_CONFIG_HOME="$HOME/.config/"
VISUAL=E

export BROWSER EDITOR ENV font GOBIN GOPATH GPG_TTY GS_FONTPATH HISTFILE HISTSIZE LANG LC_ALL NNN_BMS NNN_OPENER PAGER PATH PLAN9 PLUMBER PS1 READER REFER WINEDEBUG XDG_CONFIG_HOME VISUAL

touch /tmp/.wttr /tmp/.nowplaying

if ! { ps -e | grep X > /dev/null; } && [  "$(tty)" = "/dev/tty1" ] ; then
	trap '' INT
	fortune $HOME/q
	sleep 120
	trap - INT
	exec startx
fi
