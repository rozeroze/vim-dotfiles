""" File: mandragora.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-17
""" Description: detect-char, under the cursor


if exists('g:loaded_mandragora')
   finish
endif
let g:loaded_mandragora = 1

command! -range=% -nargs=0 Mandragora call <sid>mandragora(<line1>, <line2>)
function! s:mandragora(line1, line2)
   for line in range(a:line1, a:line2)
      call setline(line, join(map(split(getline(line), '\zs'), 'printf("%x", char2nr(v:val, 1))')))
   endfor
endfunction

" MEMO: v:alrauneに変更することでバッファ毎にAlrauneのon/offが設定できる……はず
let s:alraune = {}
let s:alraune.status = v:false

command! -nargs=0 Alraune call <sid>ruler()
function! s:ruler()
   if s:alraune.status
      " hide
      let s:alraune.statusline = &l:statusline ? &l:statusline : &statusline
   else
      " show
      let &statusline = '%<%f%h%m%r%=<%{matchstr(getline("."),".",col(".")-1)}> %b Hex %B Octal %{printf("%o",char2nr(matchstr(getline("."),".",col(".")-1),1))} %l,%c%V %p%%'
   endif
   let s:alraune.status = !s:alraune.status
endfunction


" vim: set ts=3 sts=3 sw=3 et :
