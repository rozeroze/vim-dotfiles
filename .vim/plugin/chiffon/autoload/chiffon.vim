" Vim plugin script
" File: chiffon.vim
" Summary: easy set guifont
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2018-09-27


function! chiffon#set(name)
   try
      if has_key(g:chiffon, a:name)
         if has_key(g:chiffon[a:name], 'font')
            let &guifont = g:chiffon[a:name]['font']
         endif
         if has_key(g:chiffon[a:name], 'wide')
            let &guifontwide = g:chiffon[a:name]['wide']
         else
            set guifontwide=
         endif
      else
         echo printf('fail: %s is not found. -chiffon.vim', a:name)
      endif
   catch /.*/
      set guifont&
      set guifontwide&
   endtry
endfunction

function! chiffon#default()
   if exists('g:chiffon.default')
      call chiffon#set('default')
      return
   endif
   if has('win32')
      set guifont=Consolas:h12:b
      set guifontwide=HGｺﾞｼｯｸE:h12
      return
   endif
   if has('mac')
      set guifont=Osaka－等幅:h12
      set guifontwide=
      return
   endif
   if has('unix')
      set guifont&
      set guifontwide&
      return
   endif
   set guifont&
   set guifontwide&
endfunction

function! chiffon#chiffon(...)
   if !exists('g:chiffon') || type(g:chiffon) != v:t_dict
      return
   endif
   if a:0 == 0
      call chiffon#default()
   else
      call chiffon#set(a:1)
   endif
endfunction


" vim: set ts=3 sts=3 sw=3 et :
