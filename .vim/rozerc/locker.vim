""" locker who live in


if exists('g:loaded_locker')
   finish
endif
let g:loaded_locker = 1

let s:pass = ''

command! -nargs=0 Locker :call <SID>Locker()

function! s:Locker()
   " prepare
   let input = inputsecret('set password: ')
   if len(input) == 0
      let input = 'default'
   endif
   if has('cryptv')
      let s:pass = sha256(input)
   else
      let s:pass = input
   endif
   " lock
   let locked = v:true
   silent tabnew locker
   setlocal nonumber norelativenumber nocursorline nocursorcolumn
   setlocal nolist buftype=nofile
   call append(0, '-- now locking --')
   redraw
   " unlock
   while locked
      let input = inputsecret('password: ')
      if has('cryptv')
         let input = sha256(input)
      endif
      if s:pass == input
         let locked = v:false
      endif
   endwhile
   redraw
   echo 'success unlock'
   bdelete
endfunction


" vim: set ts=3 sts=3 sw=3 et :
