" Vim plugin script
" File: chiffon.vim
" Summary: easy set guifont
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Last Change: 2018 Feb 9


function! chiffon#chiffon(...)
   if a:0 == 0
      call chiffon#chiffon(g:chiffon.default)
      return
   endif
   try
      let &guifont = g:chiffon[a:1]
   catch /.*/
      set guifont=
   endtry
endfunction


" vim: set ts=3 sts=3 sw=3 et :
