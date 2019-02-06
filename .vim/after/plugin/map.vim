


nnoremap <space>t :call <sid>t()<cr>
function! s:t()
   if exists('*OpenBrowser')
      call OpenBrowser('http://www.tenki.jp/forecast/5/26/5110/23100.html')
   endif
endfunction



" vim: set ts=3 sts=3 sw=3 et :
