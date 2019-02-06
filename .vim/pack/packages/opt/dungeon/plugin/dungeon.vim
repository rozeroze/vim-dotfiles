" Vim plugin script
" File: dungeon.vim
" Summary: dungeon keeper on Vim
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: undecided
" Version: 2018-1-1

if v:version < 800
   finish
endif
if exists('g:loaded_dungeon')
   finish
endif
let g:loaded_dungeon = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? DungeonMake :call dungeon#make(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set ts=3 sts=3 sw=3 et :
