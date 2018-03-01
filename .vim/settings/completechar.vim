""" complete char


if exists('g:loaded_completechar')
   finish
endif
let g:loaded_completechar = 1

let s:chars = split('!@#$%^&*()-_=+\|~?', '\zs')
let s:dict = []
for c in s:chars
   call add(s:dict, { 'word': c })
endfor
call add(s:dict, { 'word': '	', 'abbr': 'htab' }) " tab
call add(s:dict, { 'word': '', 'abbr': 'vtab' }) " tab

" backquote
inoremap <silent> `` <C-R>=CompleteChar()<CR>
function! CompleteChar()
   call complete(col('.'), s:dict)
   return ''
endfunction


" vim: set ts=3 sts=3 sw=3 et :
