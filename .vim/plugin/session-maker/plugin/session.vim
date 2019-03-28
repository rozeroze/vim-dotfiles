" Vim plugin script
" File: session.vim
" Summary: session make
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2018-07-09

" TODO: test
finish

if exists('g:loaded_session_maker')
   finish
endif

let s:save_cpo = &cpo
set cpo&vim


""" prepare
" if type not dict, remove it
if exists('g:session')
   if type(g:session) != v:t_dict
      unlet g:session
   endif
endif
" if not exists, define it
if !exists('g:session')
   let g:session = {}
endif
" bank
if !exists('g:session.banker')
   let g:session.banker = '$HOME/vim-sessions/'
endif
" option
if !exists('g:session.option')
   let g:session.option = 'blank,buffers,curdir,folds,globals,help,localoptions,options,slash,tabpages,winsize'
endif
" viminfo
if !exists('g:session.viminfo')
   let g:session.viminfo = v:false
endif
" quickfix
if !exists('g:session.quickfix')
   let g:session.quickfix = v:false
endif
" smoke -- shortcut
if !exists('g:session.smoker')
   let g:session.smoker = 'load'
endif
" default-name
if !exists('g:session.defaultname')
   let g:session.defaultname = 'session'
endif
" options
if !exists('g:session.topt')
   let g:session.topt = {}
endif
" make -opts
if !exists('g:session.topt.make')
   let g:session.topt.make = ['m', '-m', 'make', '-make']
endif
" load -opts
if !exists('g:session.topt.load')
   let g:session.topt.load = ['l', '-l', 'load', '-load']
endif
" list -opts
if !exists('g:session.topt.list')
   let g:session.topt.list = ['list', '-list']
endif

""" auto action
" auto save
if exists('g:session.autosave')
   if g:session.autosave
      autocmd VimLeave * call session#session(g:session.topt.make[0] . ' ' . g:session.autosave)
   endif
endif
" auto load
if exists('g:session.autoload')
   if g:session.autoload
      autocmd VimEnter * call session#session(g:session.topt.load[0] . ' ' . g:session.autoload)
   endif
endif

command! -nargs=* Session :call session#session(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_session_maker = 1


" vim: set ts=3 sts=3 sw=3 et :
