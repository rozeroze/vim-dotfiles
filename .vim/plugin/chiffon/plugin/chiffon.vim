" Vim plugin script
" File: chiffon.vim
" Summary: easy set guifont
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2018-09-27


if exists('g:loaded_chiffon')
   finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? Chiffon :call chiffon#chiffon(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_chiffon = v:true

" vim: set ts=3 sts=3 sw=3 et :
