""" File: expandspace.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-12-19
""" Description: interrupt/cut-in space, like 'expandtab'

" interchange multibyte-space to spaces when inserting it
" for example, 'expandtab' is convert <tab> to spaces.
" likewise, this convert <multibyte-space> to spaces.

if exists('g:loaded_expandspace')
   finish
endif
let g:loaded_expandspace = 1

" mutibyte-space to space*2
inoremap 　   
nnoremap 　  
xnoremap 　  

" vim: set ts=3 sts=3 sw=3 et :
