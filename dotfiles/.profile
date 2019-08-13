BROWSER=glinks
EDITOR=rlsam
ENV=$HOME/.kshrc
font='/mnt/font/Go Mono/11a/font'
GOBIN=$GOPATH/bin
GOPATH=$HOME/go
GS_FONTPATH=/usr/share/fonts
HISTFILE=$HOME/.ksh-history
HISTSIZE=100
LANG='en_US.utf8'
LC_ALL=en_US.UTF-8
NNN_BMS='v:~/videos;m:~/music;u:~/university'
PAGER=less
PATH=$HOME/bin/games:$HOME/bin/jre:$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH
PLAN9=/usr/lib/plan9
PLUMBER=plumb
READER=zathura
REFER=$HOME/.bibliography
WINEDEBUG='-all'


if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
GPG_TTY=$(tty)
NNN_OPENER=plumb

export GOPATH GOBIN GPG_TTY SSH_AUTH_SOCK PLAN9 PLUMBER REFER NNN_BMS GS_FONTPATH ENV HISTFILE HISTSIZE LANG LC_ALL EDITOR PAGER READER BROWSER PATH PS1 font WINEDEBUG NNN_OPENER

