""" File: completion.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-30


if exists('g:loaded_completion')
   finish
endif
let g:loaded_completion = 1

let s:char = map(split('!@#$%^&*()-_=+\|~?`', '\zs'), {idx, val -> { 'word': val } })
call add(s:char, { 'word': '	', 'abbr': '[htab]' }) " horizontal-tab
call add(s:char, { 'word': '', 'abbr': '[vtab]' }) " vertical-tab

inoremap <silent> `` <c-r>=<sid>complete_char()<cr>
function! s:complete_char()
   call complete(col('.'), s:char)
   return ''
endfunction

inoremap <silent> `d <c-r>=<sid>complete_date()<cr>
function! s:complete_date()
   let localtime = localtime()
   call complete(col('.'), [
            \ strftime('%Y-%m-%d', localtime),
            \ strftime('%Y%m%d', localtime),
            \ strftime('%Y/%m/%d', localtime)
            \ ])
   return ''
endfunction

inoremap <silent> `t <c-r>=<sid>complete_time()<cr>
function! s:complete_time()
   let localtime = localtime()
   call complete(col('.'), [
            \ strftime('%H:%M', localtime),
            \ strftime('%H%M', localtime)
            \ ])
   return ''
endfunction


" vim: set ts=3 sts=3 sw=3 et :
