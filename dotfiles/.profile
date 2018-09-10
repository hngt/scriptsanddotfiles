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

export ENV HISTFILE HISTSIZE LANG LC_ALL EDITOR PAGER READER BROWSER PATH PS1
