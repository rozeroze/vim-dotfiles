" file: after/plugin/map.vim
" version: 2019-03-04


let s:urls = {
           \   'tenki': 'http://www.tenki.jp/forecast/5/26/5110/23100.html',
           \   'calendar': 'http://www.benri.com/calendar/'
           \ }
command! -nargs=1 OpenBrowserEx :call <sid>OpenBrowserEx(<f-args>)<cr>
function! s:OpenBrowserEx(arg)
   if !exists('*OpenBrowser')
      echoerr 'not available openbrowser'
      return
   endif
   if has_key(s:urls, a:arg)
      call OpenBrowser(s:urls[a:arg])
   else
      echoerr printf('not found %s', a:arg)
   endif
endfunction



" vim: set ts=3 sts=3 sw=3 et :
