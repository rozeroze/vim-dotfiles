""" File: setset.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-12-21


if exists('g:loaded_setset')
   finish
endif
let g:loaded_setset = 1

command! -nargs=+ Setset call <sid>setset(<f-args>)

let s:status = 0

function! s:setset(...)
   let args = a:000
   try
      call <sid>{args[0]}()
   catch /^Vim\%((\a\+)\)\=:E117/
      echoerr 'コマンドが違います'
   endtry
endfunction

function! s:stand()
   let s:status = 1
endfunction

function! s:down()
   let s:status = 0
endfunction


" vim: set ts=3 sts=3 sw=3 et :
