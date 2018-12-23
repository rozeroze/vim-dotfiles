""" File: vimvc/client.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

function! vimvc#client#ping()
   let slist = split(serverlist(), '\n')
   call filter(slist, 'v:val == "VIMVCSERVER"')
   return len(slist) == 1
endfunction

function! vimvc#client#init()
   if !vimvc#client#ping()
      echo 'server not found'
      return
   endif
   setlocal filetype=vimvc
   setlocal buftype=nofile
   nnoremap <nowait><silent> <LeftMouse> <LeftMouse>:call vimvc#client#click()<cr>
   call vimvc#client#access('index')
endfunction

function! vimvc#client#click()
   if !vimvc#client#ping()
      echo 'server not found'
      return
   endif
   let text = expand('<cWORD>')
   if text =~ '^\[link:.*]$'
      let link = matchstr(text, '^\[link:\zs.*\ze]$')
      call vimvc#client#access(link)
   elseif text =~ '^\[action:.*]$'
      let action = matchstr(text, '^\[action:\zs.*\ze]$')
      let input = input("text: ")
      call vimvc#client#access(action, input)
   endif
endfunction

function! vimvc#client#access(route, ...)
   try
      if a:0 == 0
         let result = remote_expr('VIMVCSERVER', printf('vimvc#controller#%s()', a:route))
      else
         let result = remote_expr('VIMVCSERVER', printf('vimvc#controller#%s("%s")', a:route, a:1))
      endif
   catch
      let result = remote_expr('VIMVCSERVER', 'vimvc#controller#404()')
   endtry
   let result = eval(result)
   call vimvc#client#render(result.text)
   if has_key(result, 'script')
      call execute(result.script)
   endif
endfunction

function! vimvc#client#render(text)
   silent execute '%d'
   call append(0, a:text)
   redraw
endfunction

" vim: set ts=3 sts=3 sw=3 et :
