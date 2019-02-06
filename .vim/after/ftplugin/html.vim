""" Vim Filetype Plugin
" Language: html
" Summary: extend *.html file config
" Version: 2018-10-23


setlocal textwidth=0
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
syntax sync minlines=200 maxlines=800

" emmet
if exists('g:loaded_emmet_vim')
   nnoremap <buffer><silent> <space>e :call emmet#expandAbbr(3, '')<cr>
   vnoremap <buffer><silent> <space>e :call emmet#expandAbbr(2, '')<cr>
endif

" instead of ftplugin/cshtml and vbhtml
if expand('%:e') == 'cshtml' || expand('%:e') == 'vbhtml'
   syntax keyword RazorTodo contained TODO FIXME HACK MEMO NOTE REVIEW XXX
   syntax region RazorComment start="@\*" end="\*@" contains=RazorTodo
   highlight default link RazorTodo Todo
   highlight default link RazorComment Comment
   syntax region javascriptComment start="@\*" end="\*@"
endif

" format
nnoremap <buffer><silent> gq :call <sid>gq()<cr>
function! s:gq()
   silent! execute '%s///g'
   silent! execute '%s/>/>\r/g'
   silent! execute '%s/\ze<\//\r/g'
   silent! execute '%s/\s\+$//g'
   silent! execute 'global /^$/ normal dd'
   silent! execute 'normal gg=G'
endfunction

" vim: set ts=3 sts=3 sw=3 et :
