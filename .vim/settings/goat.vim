""" Theme: take it easy, go to file
""" Summary: 予め予約されたファイルを開くことができる
""" Version: 2019-02-18


" TODO: autocmd BufReadCmd *: call <sid>goat(*)
" TODO: edit vim: -> edit $HOME/.vim
"       edit abc: -> edit $HOME/ABC-ltd/project/abc-api

if exists('g:loaded_goat')
   finish
endif
let g:loaded_goat = 1

augroup Goat
   autocmd!
   autocmd BufReadCmd *: call <sid>goat(expand('<afile>')[:-2])
   autocmd BufReadCmd *+ call <sid>goatadd(expand('<afile>')[:-2])
   autocmd BufReadCmd *- call <sid>goatremove(expand('<afile>')[:-2])
augroup END

let s:list = {}
let s:list['vim'] = '$HOME/.vim'
let s:list['vimrc'] = '$MYVIMRC'
let s:list['gvimrc'] = '$MYGVIMRC'
let s:list['home'] = '$HOME'
"let s:list['name'] = 'path'

for s:key in keys(s:list)
   lockvar s:list[s:key]
endfor
unlet s:key

function! s:goat(name)
   echo a:name
   if has_key(s:list, a:name)
      execute "e " . s:list[a:name]
   else
      echoerr printf('error: %s is not defined', a:name)
   endif
endfunction

function! s:goatadd(name)
   if !has_key(s:list, a:name)
      normal! 
      let cname = expand('%:p')
      if cname == ''
         let cname = getcwd()
      endif
      let s:list[a:name] = cname
   else
      echoerr printf('error: %s is already defined', a:name)
   endif
endfunction

function! s:goatremove(name)
   if has_key(s:list, a:name)
      normal! 
      if islocked(printf('s:list["%s"]', a:name))
         echoerr printf('error: cannot remove %s', a:name)
      else
         unlet s:list[a:name]
      endif
   else
      echoerr printf('error: %s is not defined', a:name)
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
