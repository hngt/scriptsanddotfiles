#!/bin/sh
sed "
	s/title\s*=\s*{\(.*\)},*/%T \1/I
	s/author\s*=\s*{\(.*\)},*/%A \1/I
	s/publisher\s*=\s*{\(.*\)},*/%I \1/I
	s/doi\s*=\s*{\(.*\)},*/%K \1/I
	s/journal\s*=\s*{\(.*\)},*/%J \1/I
	s/volume\s*=\s*{\(.*\)},*/%V \1/I
	s/number\s*=\s*{\(.*\)},*/%N \1/I
	s/pages\s*=\s*{\(.*\)},*/%P \1/I
	s/year\s*=\s*\([0-9]*\),*/%D \1/I
	s/^\s*//g
	/^[^%]/d
	s/\({\|}\)//g
" "$@"