set encoding=utf-8
scriptencoding utf-8


""" secret files (password, api-token etc...)
for spath in split(glob($HOME.'/.vim/secrets/*'), '\n')
   execute 'source ' . spath
endfor
""" user-plugin configs
let g:session = {}
let g:session.quickfix = v:true
let g:chiffon = {
         \ 'anz':  'あんずもじ等幅:h12:cSHIFTJIS:qDRAFT',
         \ 'misaki':  '美咲ゴシック:h12:cSHIFTJIS:qDRAFT',
         \ 'myrica': 'MyricaM_M:h12:b:cSHIFTJIS:qDRAFT',
         \ 'default': 'anz'
         \}
""" user-plugins
for spath in split(glob($HOME.'/.vim/plugins/*'), '\n')
   if spath !~# '\~$' && isdirectory(spath)
      let &runtimepath = &runtimepath . ',' . spath
   end
endfor
for spath in split(glob($HOME.'/.vim/after/plugins/*'), '\n')
   if spath !~# '\~$' && isdirectory(spath)
      let &runtimepath = &runtimepath . ',' . spath
   end
endfor
""" my-setting configs
let g:loaded_intro_schedule = 1
let g:loaded_investor = 1
let g:loaded_chess = 1
let g:loaded_chessboard = 1
let g:loaded_quickfixdo = 1
"let g:loaded_rolling_color = 1
let g:loaded_rozeonline = 1
let g:rzrz = {}
let g:rzrz.goat = {
         \ 'wm': 'D:\workmemory',
         \ 'workmmemory': 'D:\workmemory'
         \}
call extend(g:rzrz.goat, secret#get_goat())
""" my-settings
for spath in split(glob($HOME.'/.vim/settings/*.vim'), '\n')
   execute 'source ' . spath
endfor
unlet spath

set number
set relativenumber

set nowrap
set display=lastline

set textwidth=0

set autoindent
set smartindent

set autochdir

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

set encoding=utf-8
set fileencodings=utf-8,cp932,ucs-2,utf-16le,euc-jp,iso-2022-jp,ucs-2le,sjis
set fileformats=unix,dos,mac

set noundofile

set backup
set backupdir=C:\bak~

set path+=$VIM
set path+=$HOME

set ignorecase
set smartcase
set infercase

set nrformats=

set foldmethod=marker

set cryptmethod=blowfish2

set cursorline
set formatoptions=q
set noswapfile

set scrolloff=3
set sidescroll=1
set sidescrolloff=5

set path+=$HOME\AppData\Local\Programs\Python\Python35
"set pyxversion=3

syntax on

au BufRead,BufNewFile *.cshtml  set filetype=html

set visualbell
set t_vb=

set splitbelow
set splitright

set synmaxcol=1000

set noautoread

set conceallevel=2
set concealcursor=nvic

set winaltkeys=no

set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after


""" easy command
" get current file path {{{
command! GetCurrentFilePath call GetCurrentFilePath()
function! GetCurrentFilePath()
   let path = expand("%:p")
   let @* = path
endfunction
" }}}

""" package
" movable tag {{{
" ex: # is cursor
"   <div c#ass="start">
"     <span class="middle">if you put '%' button</span>
"   </div>
" rem: cursor is moved match-tag
"   <div class="start">
"     <span class="middle">cursor moves to match-tag</span>
"   <#div>
packadd matchit
" }}}


" vim: set ts=3 sts=3 sw=3 et fdm=marker :
