syntax off            " disable syntax highlighting
set expandtab        " changing tabs into spaces
set tabstop=4        " tab = 4
set shiftwidth=4     " ditto
set number           " show numbers
set laststatus=2     " show status line 
set swapfile " have your stuff backuped
set backup
set backupdir=~/.backup " have backuped files in one dir
set dir=~/.backup
set undodir=~/.backup
set t_Co=256
let en_1=&fileencoding?&fileencoding:&encoding "set en1 to show encoding
" creating status line
set statusline =%F   " Absolute path
set statusline+=%=   " go to other side
set statusline+=%c\  " show column
set statusline+=%l/\%L "current line
set statusline+=\ [%{en_1}] "encpdong
set statusline+=\ %y   " filetype
hi StatusLine ctermbg=black ctermfg=white "colorg
" mutt stuff
autocmd BufNewFile,BufRead /tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 fo+=t linebreak wrap nonumber digraph nolist
autocmd BufNewFile,BufRead ~/tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 fo+=t wrap linebreak nonumber digraph nolist
" working hebrew input
nmap <F2> <C-[>:set rl allowrevins keymap=hebrew <CR>
nmap <F3> <C-[>:set norl noallowrevins keymap="" <CR>
" latex stuff
nmap ;tex <C-[>:w \| silent exec "!pdflatex %" \| redraw! <CR>
"colors
hi clear SpellBad
hi SpellBad cterm=undercurl,bold ctermfg=red
