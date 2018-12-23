""" File: syntax/doteditor.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-20
""" Description: おえかき

if exists('b:current_syntax')
   finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax clear

syntax match DotEditorBlack   'B'
syntax match DotEditorBlue    'b'
syntax match DotEditorRed     'r'
syntax match DotEditorMagenta 'm'
syntax match DotEditorLime    'l'
syntax match DotEditorCyan    'c'
syntax match DotEditorYellow  'y'
syntax match DotEditorWhite   'w'
highlight DotEditorBlack   guifg=#000000 guibg=#000000
highlight DotEditorBlue    guifg=#0000ff guibg=#0000ff
highlight DotEditorRed     guifg=#ff0000 guibg=#ff0000
highlight DotEditorMagenta guifg=#ff00ff guibg=#ff00ff
highlight DotEditorLime    guifg=#00ff00 guibg=#00ff00
highlight DotEditorCyan    guifg=#00ffff guibg=#00ffff
highlight DotEditorYellow  guifg=#ffff00 guibg=#ffff00
highlight DotEditorWhite   guifg=#ffffff guibg=#ffffff

let b:current_syntax = 'doteditor'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set ts=3 sts=3 sw=3 et :
