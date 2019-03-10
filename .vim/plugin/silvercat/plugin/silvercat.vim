" vim plugin script
" File: silvercat.vim
" Summary: Make ruler warm and fuzzy
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2017-10-1

if v:version < 800
   finish
endif
if !has('timers')
   finish
endif
if !has('gui_running')
   finish
endif

if exists('g:loaded_silvercat')
   finish
endif
let g:loaded_silvercat = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=0 SilverCat :call silvercat#silvercat()

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set ts=3 sts=3 sw=3 et :
