" vim filetype plugin
" Language: cshtml
" Author: rozeroze <rosettastone1886@gmail.com>
" Version: 2018-12-04

if exists('b:did_ftplugin')
   finish
endif
let b:did_ftplugin = 1

setlocal matchpairs+=<:>
setlocal commentstring=@**%s**@
setlocal comments=sl1:@**,mb1:*,ex1:**@

setlocal formatoptions-=t
setlocal formatoptions+=croql

" emmet
if exists('g:loaded_emmet_vim')
   nnoremap <buffer><silent> <space>e :call emmet#expandAbbr(3, '')<cr>
   vnoremap <buffer><silent> <space>e :call emmet#expandAbbr(2, '')<cr>
endif


" package matchit
if exists('loaded_matchit')
   let b:match_ignorecase = 1
   let b:match_words = '<:>'
                   \ . ',<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>'
                   \ . ',<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>'
                   \ . ',<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

let b:undo_ftplugin = 'setlocal formatoptions< comments< commentstring< matchpairs<'
                  \ . ' | unlet! b:match_ignorecase b:match_skip b:match_words'

" vim: set ts=3 sts=3 sw=3 et :
