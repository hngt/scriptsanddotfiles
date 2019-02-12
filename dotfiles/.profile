ENV=$HOME/.kshrc
HISTFILE=$HOME/.ksh-history
HISTSIZE=100
LANG='en_US.utf8'
LC_ALL=en_US.UTF-8
EDITOR=rlsam
PAGER=less
READER=zathura
BROWSER=glinks
PATH=$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH
PS1='${PWD##*/}\$ '
GS_FONTPATH=/usr/share/fonts
NNN_BMS='v:~/videos;m:~/music;u:~/university'
REFER=$HOME/.bibliography
PLUMBER=plumb
PLAN9=/usr/lib/plan9
font='/mnt/font/Go Mono/11a/font'

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
GPG_TTY=$(tty)

export GPG_TTY SSH_AUTH_SOCK PLAN9 PLUMBER REFER NNN_BMS GS_FONTPATH ENV HISTFILE HISTSIZE LANG LC_ALL EDITOR PAGER READER BROWSER PATH PS1 font

