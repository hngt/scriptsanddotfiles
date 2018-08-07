#!/bin/sh
# Depends: xsel or sselp.

selprint="xsel"
text=""
if [ "$1" != "" ]; then
	text="$1"
else
	text=$("$selprint")
fi
regexmatch() {
	printf '%s' "$1" | grep -E -q "$2"
}
dir=""
file=""
if regexmatch $text '^file://'; then
	text="$(echo ${text#file:\/\/} | sed 's@+@ @g;s@%@\\x@g' | xargs -0 printf "%b")"
	echo $text
fi
if [ -d "$text" ]; then
	dir="$text"
elif [ "$APP_PATH" != "" ] && [ -d "$APP_PATH/$text" ]; then
	dir="$APP_PATH/$text"
elif [ -f "$text" ]; then
	file="$text"
elif [ "$APP_PATH" != "" ] && [ -f "$APP_PATH/$text" ]; then
	file="$APP_PATH/$text"
fi

# gopher plumber
if regexmatch "$text" '^gopher://'; then
	filename=$(basename "$text" | sed 's@^\.*@@g')
	mkdir -p "/tmp/gophertmp"
	chmod 700 "/tmp/gophertmp"
	out="/tmp/gophertmp/${filename}"
	gophertype=$(printf '%s' "$text" | \
		sed -E -e 's@^gopher://@@g' -e 's@^[^/]*/?@@g' | \
		cut -b 1)

	# Download to temp dir.
	curl "$text" -o "$out"
	if test "$gophertype" = "" || test "$gophertype" = "1"; then
		st -e sacc "$text"
	elif test "$gophertype" = "0"; then
		st -e less "$out"
		echo "$out" 
	elif test "$gophertype" = "I"; then
		sxiv "$out"
	elif regexmatch "$text" '\.(mkv|mp4|avi|webm|ogg|ogv|gifv)$'; then
		mpv "$out"
	elif regexmatch "$text" '\.(png|jpg|jpeg|gif)$'; then
		sxiv "$out"
	fi
	 rm -f "$out"

	# NOTE: must exit here, we don't want to handle shellscripts etc.
	exit $?
fi

# movie (can also be an url).
# movie url.
if regexmatch "$file" '\.(mkv|mp4|avi|webm|ogg|ogv|gifv|gif)$'; then
	mpv --quiet "$file"
elif regexmatch "$file" '\.(pdf|mobi|epub|djvu|ps)$'; then
	zathura "$file"
elif regexmatch "$text" '\.(mkv|mp4|avi|webm|ogg|ogv|gifv|gif)$'; then
	mpv "$text"
elif regexmatch "$text" ':\/\/i\.imgur\.com\/'; then
	# download, view in feh, then delete.
	tmp=$(mktemp)
	curl -H 'User-Agent:' "$text" > "$tmp"
	test -f "$tmp" && sxiv "$tmp"
	rm -f "$tmp"
elif regexmatch "$text" '(\.youtube\.|youtu\.be)'; then
	mpv "$text"
elif regexmatch "$text" 'sprunge\.us'; then
	# sprunge: download, view in less, then delete.
	tmp=$(mktemp)
	curl -H 'User-Agent:' "$text" > "$tmp"
	st -e most "$tmp"
	rm -f "$tmp"
elif regexmatch "$text" '\.(pdf|mobi|epub|djvu|ps)$'; then
	# pdf handler
	tmp=$(mktemp)
	curl -H 'User-Agent:' "$text" > "$tmp"
	zathura "$tmp"
	rm -f "$tmp"
elif [ x"$dir" != x"" ]; then
	cd "$dir"
	st
elif [ x"$file" != x"" ]; then
	if regexmatch "$file"'\.(sh)$'; then
		sh "$file"
	elif regexmatch "$file" '\.(png|jpg|jpeg|gif)$'; then
		# image files.
        tmp=$(mktemp)
	    curl -H 'User-Agent:' "$text" > "$tmp"
	    test -f "$tmp" && sxiv "$tmp"
	    rm -f "$tmp"
	fi
else
	if regexmatch "$text" '^(http|https)://.*twitch\.tv'; then
		# stream link.
		mpv "$text"
    elif regexmatch "$text" '^(http|https)://.*mega\.nz'; then
         # mega nz links
         temp=$(mktemp -d -p /home/lich/downloads) 
         megadl "$text" --path $temp
	elif regexmatch "$text" '^(http|https)://'; then
		# url
		 newsopen "$text"
	elif regexmatch "$text" '^www\.'; then
		# url
		 newsopen "$text"
	elif regexmatch "$text" '^magnet'; then
		# magnet link.
		transmission-remote -a "$text"
	fi
fi

exit $?
