" Vim plugin script
" File: dungeon.vim
" Summary: dungeon keeper on Vim
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: undecided
" Version: 2018-1-1

if exists('b:current_syntax')
   finish
endif

syntax clear

syntax match dungeonWall /[+-|]/
syntax match dungeonFloor /\./
syntax match dungeonKeeper /#/
syntax match dungeonMonster /[\^3\@\&\!8\=\~\*\$]/
syntax match dungeonGate /%/
syntax match dungeonBrave /[FSBKLTRAWMC]/

highlight default link dungeonWall String
highlight default link dungeonFloor Normal
highlight default link dungeonKeeper Boolean
highlight default link dungeonMonster String
highlight default link dungeonGate Float
highlight default link dungeonBrave Number

let b:current_syntax = 'dungeon'

" vim: set ts=3 sts=3 sw=3 et :
