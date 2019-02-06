""" Vim Filetype Plugin
" Language: json
" Summary: extend *.json vim file config
" Version: 2018-07-12

setlocal textwidth=0
setlocal tabstop=3
setlocal softtabstop=3
setlocal shiftwidth=3
setlocal expandtab

setlocal concealcursor=c

nnoremap <buffer><silent> gq :call <sid>gq()<cr>
function! s:gq()
   let lr = &lazyredraw
   let &lazyredraw = v:true
   silent! execute '%s/{/{\r/g'
   silent! execute '%s/}/\r}/g'
   silent! execute '%s/\[/[\r/g'
   silent! execute '%s/]/\r]/g'
   silent! execute '%s/:\ze\S/: /g'
   silent! execute '%s/,/,\r/g'
   silent! execute '%s/\s\+$//g'
   silent! execute 'global /^$/ normal dd'
   silent! execute 'normal! gg=G'
   let &lazyredraw = lr
endfunction

" vim: set ts=3 sts=3 sw=3 et :
