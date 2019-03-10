" file: after/plugin/map.vim
" version: 2019-03-10


let s:urls = {
           \   'tenki': 'http://www.tenki.jp/forecast/5/26/5110/23100.html',
           \   'calendar': 'http://www.benri.com/calendar/'
           \ }
command! -nargs=1 -complete=customlist,<sid>urlmaps OpenBrowserEx :call <sid>OpenBrowserEx(<f-args>)
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
function! s:urlmaps(ArgLead, CmdLine, CursorPos)
   let keys = keys(s:urls)
   "return filter(keys, {idx, val -> val =~ "^" . a:ArgLead }) " +lambda
   return filter(keys, 'v:val =~ "^' . a:ArgLead . '"')
endfunction



" vim: set ts=3 sts=3 sw=3 et :
