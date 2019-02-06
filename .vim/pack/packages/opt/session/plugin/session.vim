" Vim plugin script
" File: session.vim
" Summary: session manager
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2019-01-24


if exists('g:loaded_session')
   finish
endif
let g:loaded_session = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=+ Session :call session#session(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo


" vim: set ts=3 sts=3 sw=3 et :
