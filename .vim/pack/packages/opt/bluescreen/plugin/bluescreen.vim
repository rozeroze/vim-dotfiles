""" File: bluescreen.vim
""" Authors: rozeroze <rosettastone1886@gmail.com>
""" License: MIT
""" Version: 2018-09-19

""" Description: blue screen of death

if exists('g:loaded_bluescreen')
   finish
endif
let g:loaded_bluescreen = 1

let s:save_cpo = &cpo
set cpo&vim

" command
command! -nargs=0 BlueScreen :call bluescreen#bluescreen()
" autocmd screensaver 5min
"set updatetime=300000
"autocmd! CursorHold * :call bluescreen#bluescreen()

let &cpo = s:save_cpo
unlet s:save_cpo


" vim: set ts=3 sts=3 sw=3 et :
