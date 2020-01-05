#!/bin/zsh
# functions

typeset -a ialiases
ialiases=()

ialias() {
	alias $@
	args="$@"
	args=${args%%\=*}
	ialiases+=(${args##* })
}

# functionality
expand-alias-space() {
	[[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
	if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then
		zle _expand_alias
	fi
	zle self-insert
	if [[ "$insertBlank" = "0" ]]; then
		zle backward-delete-char
	fi
}
zle -N expand-alias-space



alarm() { sleep $1 && printf "$2\a\n"; }
background() {
	for ((i=2;i<=$#;i++)); do
		${@[1]} ${@[$i]} &> /dev/null &
	done
}
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.tar.xz)    tar xJf $1		;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
mkwebm() { ffmpeg -i "$1" -c:v libx264 -preset fast -b:v "$3" -c:a libvorbis "$2"; }
file0() { curl -sL -F files[]=@"$1" https://file0.s3kr.it/upload | sed -n 's@.*https*://file0.s3kr.it/@https://file0.s3kr.it/@;s@'\'')">@@p'; }
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}
psgrep() { grep $1 =(ps aux); }

alias em='doas emerge --color n' \
	e='$EDITOR' \
	eix='eix -n' \
	g='git' \
	i='irssi' \
	ll='ls -Flrt --color=auto' \
	tv='noglob mpv --audio-device="alsa/hdmi:CARD=PCH,DEV=0"' \
	m='mutt' \
	mchenye='awk -vdate="^$(date +%-m:%-d)" '\''$0 ~ date {gsub("(^[0-9]*:[0-9]* )", "kjv ", $0);gsub("; ", "&kjv ", $0) ; print $0}'\'' $HOME/.mchenye  | sh' \
	mkd='mkdir -pv' \
	mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS' \
	mpv='noglob mpv' \
	mkpdf='libreoffice --headless --convert-to pdf' \
	no_blank='xset -dpms && xset s off' \
	nvi='sam -d' \
	o='mocp' \
	off='sudo poweroff' \
	p='zathura' \
	rcs='sudo /sbin/rc-service' \
	svi='sudo vis' \
	s='sfeed_update && tscrape_update && sfeed_html $HOME/.sfeed/feeds/* > /tmp/feeds.html &&  torsocks mbsync -a' \
	t='tmux' \
	trem='transmission-remote' \
	v="mpv" \
	vi='vis' \
	vim='vis' \
	yt='noglob youtube-dl --add-metadata -ic' \
	yta='yt -x -f bestaudio/best --ignore-config --add-metadata' \
	ync='yt --ignore-config' \
	x='sxiv -ft *' \
	xvga='xrandr --output VGA-1 --primary'
alias -g L='| less' \
	G='| grep'
ialias -g grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
ialias -g ls='ls -F --color=auto'
ialias -g l='ls -F --color=auto'
alias -s {mp4,mkv,webm}='background mpv --no-terminal' \
	{pdf,epub}='background zathura'

# imports

. $HOME/.private-commands
. $HOME/.zkeys
# zsh settings
autoload -Uz compinit promptinit
compinit
promptinit
PROMPT='%(?..?%?)%2~%# '
RPROMPT='%*'
zstyle ':completion:*' menu select
setopt append_history
setopt AUTO_CD
setopt completealiases
setopt COMPLETE_ALIASES
setopt CORRECT
setopt extendedglob
setopt hist_ignore_all_dups
setopt hist_verify
setopt NO_CASE_GLOB
setopt share_history
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
_comp_options+=(globdots)
export SAVEHIST=$HISTSIZE
zstyle ':completion:*' rehash true


case "$TERM" in
           xterm*) TERM=xterm-256color ;;
           rxvt*) printf '\033[5 q\r' ;;
       esac

