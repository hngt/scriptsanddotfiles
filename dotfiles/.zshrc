#export PS1='${?#0}\W\T\$ '
alias em='doas emerge --color n' \
	e='$EDITOR' \
	eix='eix -n' \
	g='git' \
	i='irssi' \
	ll='ls -Flrt --color=auto' \
	ls='ls -F --color=auto' \
	tv='mpv --audio-device="alsa/hdmi:CARD=PCH,DEV=0"' \
	m='mutt' \
	mkd='mkdir -pv' \
	mkopus='SAVEIFS=$IFS;IFS=$'\n';for i in *flac; do ffmpeg -i $i -acodec libopus -b:a 160k ${i%flac}opus;done;IFS=$SAVEIFS' \
	mkpdf='libreoffice --headless --convert-to pdf' \
	no_blank='xset -dpms && xset s off' \
	nvi='sam -d' \
	o='mocp' \
	off='doas poweroff' \
	p='zathura' \
	rcs='doas /sbin/rc-service' \
	svi='doas vis' \
	s='sfeed_update && tscrape_update && sfeed_html $HOME/.sfeed/feeds/* > /tmp/feeds.html &&  torsocks mbsync -a' \
	t='tmux' \
	trem='transmission-remote' \
	v="mpv" \
	vi='vis' \
	vim='vis' \
	vis='cat' \
	yt='youtube-dl --add-metadata -ic' \
	yta='yt -x -f bestaudio/best --ignore-config --add-metadata' \
	ync='yt --ignore-config' \
	x='sxiv -ft *' \
	xvga='xrandr --output VGA-1 --primary'

. $HOME/.private-commands

bindkey -e 
autoload -Uz compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
_comp_options+=(globdots)
prompt redhat

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
mocpShow() { mocp <$TTY; zle redisplay; }
zle -N mocpShow
bindkey '^[\' mocpShow

alarm() { sleep $1 && printf "$2\a\n"; }
mkwebm() { ffmpeg -i "$1" -c:v libvpx -b:v "$3" -c:a libvorbis "$2"; }
file0() { curl -sL -F files[]=@"$1" https://file0.s3kr.it/upload | sed -n 's@.*https*://file0.s3kr.it/@https://file0.s3kr.it/@;s@'\'')">@@p'; }
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | sed -nE 's/.*location.href.*(http.*.pdf)\?.*/\1/p') ;}

case "$TERM" in
           xterm*) TERM=xterm-256color ;;
           rxvt*) printf '\033[5 q\r' ;;
       esac

