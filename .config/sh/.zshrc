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

background() {
	for ((i=2;i<=$#;i++)); do
		${@[1]} ${@[$i]} &> /dev/null &
	done
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}



alarm() { sleep "$1" && shift; printf "$@\a\n"; notify-send "$1" "$2"; }
mkwebm() { ffmpeg -i "$1" -c:v libx264 -preset fast -b:v "$3" -c:a libvorbis "$2"; }
shdl() { curl -O $(curl -s https://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}
psgrep() { grep $1 =(ps aux); }
cdu() { cd /run/media/$USER/$1 }
alias c='git  --git-dir=$HOME/git/dotfiles --work-tree=$HOME' \
	g='git' \
	i='weechat -d "$XDG_CONFIG_HOME"/weechat' \
	lf='lfcd' \
	ll='ls -Flrt --color=auto' \
	tv='noglob mpv --audio-device="alsa/hdmi:CARD=PCH,DEV=0"' \
	m='mutt' \
    mbsync='mbsync -c "$XDG_CONFIG_HOME/mbsyncrc"' \
	mchenye='awk -vdate="^$(date +%-m:%-d)" '\''$0 ~ date {gsub("(^[0-9]*:[0-9]* )", "kjv ", $0);gsub("; ", "&kjv ", $0) ; print $0}'\'' $HOME/lib/mchenye  | sh' \
	mkd='mkdir -pv' \
	mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS' \
	mpv='noglob mpv' \
	mkpdf='libreoffice --headless --convert-to pdf' \
	no_blank='xset -dpms && xset s off' \
    nonet='unshare -cn' \
	nvi='sam -d' \
	o='mocp -M "$XDG_CONFIG_HOME"/moc' \
	off='sudo poweroff' \
    n="sfeed_curses $HOME/.sfeed/feeds/*" \
	p='zathura' \
	s='sfeed_update;  mbsync -a;' \
	t='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf' \
	trem='transmission-remote' \
	v="mpv" \
	vi='vis' \
	vim='vis' \
	yt='noglob youtube-dl --add-metadata -ic' \
	yta='yt -x -f bestaudio/best --ignore-config --add-metadata' \
	ync='yt --ignore-config' \
	x='sxiv -ft *'
alias -g L='| less' \
	G='| grep' \
	extract='aunpack'
ialias -g grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
ialias -g ls='ls -F --color=auto'
ialias -g l='ls -F --color=auto'
alias -s {mp4,mkv,webm}='background mpv --no-terminal' \
	{pdf,epub}='background zathura'

# imports
typeset -aU path
path=( $path )
. $XDG_CONFIG_HOME/sh/zkeys
. $XDG_CONFIG_HOME/sh/private-commands
fpath=($XDG_CONFIG_HOME/sh/zsh_completions $fpath)
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
setopt inc_append_history
setopt share_history


case "$TERM" in
           xterm*) TERM=xterm-256color; printf '\033[6 q\r' ;;
           rxvt*) printf '\033[5 q\r' ;;
       esac
fortune lib/q

if [[ -a $HOME/.config/sh/zsh-ssh ]]; then
    . $HOME/.config/sh/zsh-ssh
    export GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
fi
