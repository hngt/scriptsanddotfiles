#!/bin/sh
sed "
	s/@\(book\|article\|InCollection\)\s*{\(.*\),/%L \2/I
	s/title\s*=\s*{\(.*\)},*/%T \1/I
	s/author\s*=\s*{\(.*\)},*/%A \1/I
	s/publisher\s*=\s*{\(.*\)},*/%I \1/I
	s/editor\s*=\s*{\(.*\)},*/%E \1/I
	s/doi\s*=\s*{\(.*\)},*/%K \1/I
	s/journal\s*=\s*{\(.*\)},*/%J \1/I
	s/volume\s*=\s*{\(.*\)},*/%V \1/I
	s/number\s*=\s*{\(.*\)},*/%N \1/I
	s/pages\s*=\s*{\(.*\)},*/%P \1/I
	s/booktitle\s*=\s*{\(.*\)},*/%B \1/I
	s/howpublished\s*=\s*{.url{\(.*\)}},/%O URL: \1 (accessed $(date '+%e %B %Y'))/I
	s/--/-/I
	s/%A \([A-Z.a-z]*\), \([A-Z .a-z]*\)/%A \2 \1/I
	s/year\s*=\s*{\(.*\)},*/%D \1/I
	s/^\s*//g
	/^[^%]/d
	s/\({\|}\)//g
" "$@"