" file: after/plugin/map.vim
" version: 2019-03-13


""" HACK: いつの間にかmapではなくなっている


let s:urls = {
           \   'tenki': 'http://www.tenki.jp/forecast/5/26/5110/23100/3hours.html',
           \   'calendar': 'http://www.benri.com/calendar/',
           \   'techcrunch': 'https://jp.techcrunch.com/'
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

command! TechCrunch :call <sid>TechCrunch()
function! s:TechCrunch()
   tabnew [TechCrunch]
   setlocal buftype=nofile
   let res = webapi#http#get('https://jp.techcrunch.com/')
   let dom = webapi#html#parse(res.content)
   let title = dom.find('title').value()
   call append(0, title)
   let list = dom.findAll('li', { 'class': 'river-block' })
   for item in list
      let _title = item.attr['data-shareTitle']
      let _url = item.attr['data-permalink']
      call append('$', _title)
      call append('$', _url)
      call append('$', '')
   endfor
   nnoremap <silent><nowait> x :call <sid>TechCrunchArticle(expand('<cWORD>'))<cr>
endfunction
function! s:TechCrunchArticle(url)
   if a:url !~? 'https\?://.\+'
      echoerr printf('%s is not url', a:url)
      return
   endif
   tabnew
   setlocal buftype=nofile
   setlocal wrap laststatus=0 scrolloff=0
   setlocal nocursorline nocursorcolumn
   let res = webapi#http#get(a:url)
   let dom = webapi#html#parse(res.content)
   let title = dom.find('title').value()
   let article = dom.find('article')
   let text = article.find('div', { 'class': 'article-entry text' })
   call append(0, title)
   "call append('$', text.value())
   "call append('$', split(text.value()))
   call append('$', split(text.value(), '\n'))
endfunction


" vim: set ts=3 sts=3 sw=3 et :
