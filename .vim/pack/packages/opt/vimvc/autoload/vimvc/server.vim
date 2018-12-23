""" File: vimvc/server.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

let s:path = expand('<sfile>:p:h')

function! vimvc#server#stand()
   setlocal nobackup noswapfile noundofile
   setlocal buftype=nofile
   setlocal nonumber norelativenumber
   setlocal nolist nospell nowrap
   setlocal nocursorline nocursorcolumn
   setlocal guioptions=
   command! -buffer -nargs=0 Reboot call vimvc#server#reboot()
   command! -buffer -nargs=0 Down call vimvc#server#down()
   "nnoremap <nowait> r :call vimvc#server#reboot()<cr>
   "nnoremap <nowait> d :call vimvc#server#down()<cr>
   call append(0, 'vimvc-server standed!')
endfunction

function! vimvc#server#log(text)
   call append(line('$'), a:text)
   redraw
endfunction

function! vimvc#server#reboot()
   silent execute('%d')
   call append(0, 'vimvc-server rebooted!')
   try
      call execute(printf('source %s\controller.vim', s:path))
      call execute(printf('source %s\model.vim', s:path))
      call execute(printf('source %s\view.vim', s:path))
   catch /.*/
      call append('$', 'error occurred')
   endtry
endfunction

function! vimvc#server#down()
   quitall!
endfunction

" vim: set ts=3 sts=3 sw=3 et :
