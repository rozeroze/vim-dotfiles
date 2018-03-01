""" take it easy, go to file


if exists('g:loaded_goat')
   finish
endif
let g:loaded_goat = 1

" variable
if exists('g:rzrz.goat')
   let s:goat = g:rzrz.goat
else
   let s:goat = {}
endif
let s:goat.vimrc = '$MYVIMRC'
let s:goat.gvimrc = '$MYGVIMRC'
let s:goat.home = '$HOME'
let s:goat.plugins = '$VIM/plugins'
let s:goat['.vim'] = '$HOME/.vim'

" command
command! -nargs=+ Goat :call <SID>Goat(<f-args>)

" function
function! s:Goat(...)
   if a:0 == 1
      let name = a:1
      let type = 'edit'
   else
      let name = a:2
      let type = s:GetType(a:1)
   endif
   if !len(type)
      echo 'argument error: ' . a:1 . ' is not type. -goat.vim'
      return
   endif
   if !has_key(s:goat, name)
      echo 'argument error: ' . name . ' is not found. -goat.vim'
      return
   endif
   let command = join([type, s:goat[name]])
   call execute(command)
endfunction

function! s:GetType(type)
   if a:type =~# '-\?e\(dit\)\?'
      return 'edit'
   elseif a:type =~# '-\?n\(ew\)\?'
      return 'new'
   elseif a:type =~# '-\?v\(new\)\?'
      return 'vnew'
   elseif a:type =~# '-\?t\(abnew\)\?'
      return 'tabnew'
   else
      return ''
   endif
endfunction


" vim: set ts=3 sts=3 sw=3 et :
