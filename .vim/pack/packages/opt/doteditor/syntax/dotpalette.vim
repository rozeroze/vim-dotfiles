""" File: syntax/doteditor_palette.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-20
""" Description: おえかき

if exists('b:current_syntax')
   finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax clear

syntax match DotEditorPaletteBlack   '^B'
syntax match DotEditorPaletteBlue    '^b'
syntax match DotEditorPaletteRed     '^r'
syntax match DotEditorPaletteMagenta '^m'
syntax match DotEditorPaletteLime    '^l'
syntax match DotEditorPaletteCyan    '^c'
syntax match DotEditorPaletteYellow  '^y'
syntax match DotEditorPaletteWhite   '^w'
highlight DotEditorPaletteBlack   guifg=#000000 guibg=#000000
highlight DotEditorPaletteBlue    guifg=#0000ff guibg=#0000ff
highlight DotEditorPaletteRed     guifg=#ff0000 guibg=#ff0000
highlight DotEditorPaletteMagenta guifg=#ff00ff guibg=#ff00ff
highlight DotEditorPaletteLime    guifg=#00ff00 guibg=#00ff00
highlight DotEditorPaletteCyan    guifg=#00ffff guibg=#00ffff
highlight DotEditorPaletteYellow  guifg=#ffff00 guibg=#ffff00
highlight DotEditorPaletteWhite   guifg=#ffffff guibg=#ffffff

let b:current_syntax = 'dotpalette'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set ts=3 sts=3 sw=3 et :
