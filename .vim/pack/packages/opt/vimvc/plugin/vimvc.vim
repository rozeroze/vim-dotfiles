""" File: vimvc.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-07
""" Description: VimでわかるMVC

if !has('clientserver')
   finish
endif
if exists('g:loaded_vimvc')
   finish
endif
let g:loaded_vimvc = 1

if v:servername ==# 'VIMVCSERVER'
   call vimvc#server#stand()
else
   command! VIMVC :call vimvc#client#init()
endif


" vim: set ts=3 sts=3 sw=3 et :
