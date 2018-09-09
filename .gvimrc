" rozeroze's .gvimrc
" Author: rozeroze
" Mail: rosettastone1886@gmail.com

set encoding=utf-8
scriptencoding utf-8

let s:is_win  = has('win32')
let s:is_mac  = has('mac')
let s:is_unix = has('unix')

" set-options {{{

" list
set list
"set listchars=eol:┸,tab:[_,trail:~,extends:>,precedes:<
set listchars=eol:^,tab:[_,trail:~,extends:>,precedes:<

" GUI オプション
set guioptions=

" Vim ウィンドウサイズ
set lines=24
set columns=80

" ruler statuslineの右にあるあれ << 12,34-56 78% >>
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" reset when gui start
set t_vb=

" intro gvimrc でないと効かないらしい
set shortmess+=I

" enable mouse-action
set mouse=n

" }}}

" colorscheme {{{
try
   " https://github.com/rozeroze/vim-colorschemes/blob/master/colors/frozendaiquiri.vim
   colorscheme frozendaiquiri
catch /.*/
   colorscheme desert
endtry
" }}}

" font {{{
if s:is_win
   try
      set guifont=あんずもじ等幅:h12
      set guifontwide=
   catch /.*/
      set guifont=Consolas:h12
      set guifontwide=HGｺﾞｼｯｸE:h12
   endtry
endif
" }}}

" gui-enter {{{
if exists('+transparency')
   augroup Invisible
      autocmd!
      autocmd GUIEnter * set transparency=245
   augroup END
endif
" }}}


" vim: set ts=3 sts=3 sw=3 et :
