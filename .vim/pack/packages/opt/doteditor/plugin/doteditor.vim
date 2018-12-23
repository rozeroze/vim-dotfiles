""" File: doteditor.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-20
""" Description: おえかき

if exists('g:loaded_doteditor')
   finish
endif
let g:loaded_doteditor = 1

if !exists('g:doteditor') || type(g:doteditor) != v:t_dict
   let g:doteditor = {}
endif

command! -nargs=* DotEditor :call doteditor#launch(<f-args>)

" vim: set ts=3 sts=3 sw=3 et :
