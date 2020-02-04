BROWSER=glinks
EDITOR=E
ENV=$HOME/.zshrc
FG_COL='#ececec'
BG_COL='#111111'
BGSEL_COL='#393939'
font=/mnt/font/GoMono/11a/font
GOPATH=$HOME/go
GOBIN=$GOPATH/bin
GS_FONTPATH=/usr/share/fonts
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
LANG='en_US.utf8'
LC_ALL=en_US.UTF-8
NNN_BMS='v:~/videos;m:~/music;u:~/university'
NNN_OPENER=plumb
PAGER=less
PATH=$HOME/bin/games:$HOME/bin/jre:$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH
PLAN9=/usr/lib/plan9
PLUMBER=plumb
OPENER=$PLUMBER
READER=zathura
REFER=$HOME/.bibliography
WINEDEBUG='-all'
GPG_TTY=$(tty)
XDG_CONFIG_HOME="$HOME/.config/"
VISUAL=vis

export BROWSER EDITOR ENV font GOBIN GOPATH GPG_TTY GS_FONTPATH HISTFILE HISTSIZE LANG LC_ALL NNN_BMS NNN_OPENER PAGER PATH PLAN9 PLUMBER PS1 READER REFER WINEDEBUG XDG_CONFIG_HOME VISUAL OPENER

touch /tmp/.wttr /tmp/.nowplaying

if ! { ps -e | grep X > /dev/null; } && [  "$(tty)" = "/dev/tty1" ] ; then
	trap '' INT
	fortune $HOME/q
	sleep 5
	trap - INT
	exec startx
fi
