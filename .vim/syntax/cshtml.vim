" vim syntax file
" Language: cshtml
" Author: rozeroze <rosettastone1886@gmail.com>
" Version: 2018-12-04

if exists('b:current_syntax')
   finish
endif

runtime! syntax/html.vim

" razor
syntax keyword RazorTodo contained TODO FIXME HACK MEMO NOTE REVIEW XXX
syntax region RazorComment start="@\*" end="\*@" contains=RazorTodo
highlight default link RazorTodo Todo
highlight default link RazorComment Comment


" vim: set ts=3 sts=3 sw=3 et :
