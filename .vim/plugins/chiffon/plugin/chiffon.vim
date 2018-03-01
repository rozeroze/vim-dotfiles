" Vim plugin script
" File: chiffon.vim
" Summary: easy set guifont
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Last Change: 2018 Feb 9


if exists('g:loaded_chiffon')
   finish
endif
if !exists('g:chiffon')
   finish
endif
if type(g:chiffon) != v:t_dict
   finish
endif

let s:save_cpo = &cpo
set cpo&vim

"if exists('g:chiffon.default')
"   autocmd GuiEnter * call chiffon#chiffon(g:chiffon.default)
"endif

command! -nargs=? Chiffon :call chiffon#chiffon(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_chiffon = v:true

" vim: set ts=3 sts=3 sw=3 et :
