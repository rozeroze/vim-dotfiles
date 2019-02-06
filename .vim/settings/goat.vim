""" Theme: take it easy, go to file
""" Summary: 予め予約されたファイルを開くことができる
""" Version: 2018-11-22


" TODO: autocmd BufReadCmd $.vim :e ~/.vim
" TODO: autocmd BufReadCmd :.vim :e ~/.vim

if exists('g:loaded_goat')
   finish
endif
let g:loaded_goat = 1

augroup Goat
   autocmd!
   autocmd BufReadCmd :* call <sid>goat(expand('<afile>')[1:])
   autocmd BufReadCmd goat:* call <sid>goat(expand('<afile>')[5:])
   autocmd BufReadCmd *: call <sid>goat(expand('<afile>')[:-2])
   autocmd BufReadCmd *:goat call <sid>goat(expand('<afile>')[:-6])
augroup END

let s:gset = {}
let s:gset['vim'] = '$HOME/.vim'
let s:gset['vimrc'] = '$MYVIMRC'
let s:gset['gvimrc'] = '$MYGVIMRC'
let s:gset['home'] = '$HOME'
"let s:gset['name'] = 'path'

function! s:goat(name)
   if has_key(s:gset, a:name)
      execute "e " . s:gset[a:name]
   else
      if a:flg
         normal! 
         let s:gset[a:name] = expand('%:p')
      else
         echoerr printf('error: %s is not defined', a:name)
      endif
   endif
endfunction

" e :name 2018-11-15
finish

" variable
let s:goat = {}
" basic
let s:goat['vimrc']   = '$MYVIMRC'
let s:goat['.vimrc']  = '$MYVIMRC'
let s:goat['gvimrc']  = '$MYGVIMRC'
let s:goat['.gvimrc'] = '$MYGVIMRC'
let s:goat['home']    = '$HOME'
let s:goat['vim']     = '$HOME/.vim'
let s:goat['.vim']    = '$HOME/.vim'

let s:types = ['-edit', '-new', '-vnew', '-tabnew']
let s:names = keys(s:goat)

" command
command! -nargs=+ -complete=customlist,<SID>Complete Goat :call <SID>Goat(<f-args>)

" function
function! s:Goat(...)
   if a:0 == 1
      let type = 'edit'
      let name = a:1
   elseif a:0 == 2
      let type = <SID>GetType(a:1)
      let name = a:2
   else
      echo 'argument error: too many arguments. -goat.vim'
      return
   endif
   if !len(type)
      echo printf('argument error: %s is not type. -goat.vim', a:1)
      return
   endif
   if !has_key(s:goat, name)
      echo printf('argument error: %s is not found. -goat.vim', name)
      return
   endif
   let command = join([type, s:goat[name]])
   call execute(command)
   if isdirectory(expand('%'))
      call execute('cd %', 'silent!')
   else
      call execute('cd %:h', 'silent!')
   endif
endfunction

function! s:GetType(type)
   for _t in s:types
      if a:type == _t
         return _t[1:]
      endif
   endfor
   return ''
endfunction

function! s:Complete(arglead, cmdline, cursorpos)
   let arglist = split(a:cmdline, '\s\+')
   let arglen = len(arglist)
   if arglen == 1 " :Goat
      let selection = s:types + s:names
   elseif arglen == 2 " :Goat xxx
      let selection = s:types + s:names
   elseif arglen == 3 " :Goat -opt xxx
      let selection = s:names
   else " :Goat xxx yyy zzz
      return []
   endif
   return filter(selection, printf('v:val =~ "^%s"', a:arglead))
endfunction

" vim: set ts=3 sts=3 sw=3 et :
