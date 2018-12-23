""" File: syntax/vimvc.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

if exists('b:current_syntax')
   finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax clear

syntax match vimvcLinkTo "\[link:.\{-}]"
highlight link vimvcLinkTo Number

syntax match vimvcAction "\[action:.\{-}]"
highlight link vimvcAction String

let b:current_syntax = 'vimvc'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set ts=3 sts=3 sw=3 et :
