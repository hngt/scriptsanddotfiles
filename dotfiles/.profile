ENV=$HOME/.kshrc
HISTFILE=$HOME/.ksh-history
HISTSIZE=100
LANG='en_US.utf8'
LC_ALL=en_US.UTF-8
EDITOR=vis
PAGER=most
READER=zathura
BROWSER=glinks
PATH=$HOME/.local/bin:$HOME/bin:$PATH
PS1='${PWD##*/}$(tput bold)[32m>[00m $(tput sgr0)'
GS_FONTPATH=/usr/share/fonts
NNN_BMS='v:~/videos;m:~/music;u:~/university'
REFER=$HOME/.bibliography
PLUMBER=plumb
PLAN9=/usr/lib/plan9


export PLAN9 PLUMBER REFER NNN_BMS GS_FONTPATH ENV HISTFILE HISTSIZE LANG LC_ALL EDITOR PAGER READER BROWSER PATH PS1
