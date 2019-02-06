""" Vim Filetype Plugin
" Language: sql
" Summary: extend *.sql vim file config
" Version: 2018-09-18

setlocal textwidth=0
setlocal tabstop=3
setlocal softtabstop=3
setlocal shiftwidth=3
setlocal expandtab

nnoremap <buffer><silent> gq :call <sid>gq()<cr>
function! s:gq()
   let lr = &lazyredraw
   let &lazyredraw = v:true
   silent! execute '%s/\v\ze<(select|from|where|group|order)>/\r/g'
   silent! execute '%s/\v\ze<(else|end|left|right|and|or|on)>/\r/g'
   silent! execute '%s/\v\ze(,|\))/\r/g'
   silent! execute '%s/\v\s+/ /g'
   silent! execute '%s/\v\s+$//g'
   silent! execute 'global /^$/ normal dd'
   silent! execute 'normal! gg=G'
   let &lazyredraw = lr
endfunction

" vim: set ts=3 sts=3 sw=3 et :
