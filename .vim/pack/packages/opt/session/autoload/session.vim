" Vim plugin script
" File: session.vim
" Summary: session manager
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2019-03-13


" variable
let s:session = {
              \   'path': '$HOME/',
              \   'subdir': v:false,
              \   'override': v:false
              \ }

" functions autoloads
function! session#session(cmd, ...) " {{{1
   try
      call session#{a:cmd}(a:000)
   catch /^Vim\%((\a\+)\)\=:E117/
      echoerr printf("error: command not found!")
   endtry
endfunction

function! session#set(args) " {{{1
   " :Session set -> start wizard mode
   "   or
   " :Session set ~/.vim/.session-config
   " :Session set {'path':'$HOME/','subdir':1,'override':1}
   try
      if len(a:args) == 0
         call <sid>set_wizard()
      else
         let str = join(a:args, "\n")
         if str[0] == "{"
            call <sid>set_from_stream(str)
         else
            call <sid>set_from_file(str)
         endif
      endif
   catch /.*/
      echoerr "error: setup failed."
   endtry
endfunction

function! session#list(args) " {{{1
   try
      if len(a:args) == 0
         " show all
         let list = <sid>get_all_files()
         for item in list
            echo item
         endfor
      else
         " filtering regular-expression
      endif
   catch /.*/
      echoerr "error: show session-list faild. "
   endtry
endfunction

function! session#make(args) " {{{1
   try
      let name = ( a:0 != 0 ? a:1 : 'session' . localtime() )
      if match(name, '/') != -1 || session#mkdir(name)
         execute printf('mksession%s %s',
                     \ ( s:session.override ? '!' : '' ),
                     \ ( s:session.path . name ))
      endif
   catch /.*/
      echoerr printf("error: making session failed.")
   endtry
endfunction

function! session#mkdir(args) " {{{1
   try
      "call mkdir(s:session.path . matchstr(name, '.*\ze/.*$'), 'p')
      if !s:session.subdir
         echo 'message: denied by session-option. please set subdir.'
         return v:false
      endif
      call mkdir(s:session.path . matchstr(name, '.*\ze/.*$'), 'p')
      return v:true
   catch /.*/
      return v:false
   endtry
endfunction

function! session#load(args) " {{{1
   try
   catch /.*/
   endtry
endfunction

" }}}1

" functions script-local
function s:session_object(name, ...) " {{{1
   let obj = {}
   let obj['name'] = a:name
   let obj['quickfix'] = ( a:0 >= 1 ) ? a:1 : v:false
   let obj['winpos']   = ( a:0 >= 2 ) ? a:2 : v:false
   return obj
endfunction
function s:set_wizard() " {{{1
   let tmp = deepcopy(s:session)
   for key in keys(tmp)
      let val = input(key . ': ', tmp[key])
      if val != ""
         let tmp[key] = val
      endif
   endfor
   call extend(s:session, tmp, "force")
endfunction

function s:set_from_stream(stream) " {{{1
   let tmp = eval(a:stream)
   if type(tmp) != v:t_dict
      echoerr "error: argument invalid."
      return
   endif
   call extend(s:session, tmp, "force")
endfunction

function s:set_from_file(path) " {{{1
   if !filereadable(a:path)
      echoerr "error: argument invalid."
      return
   endif
   let tmp = eval(join(readfile(a:path), "\n"))
   if type(tmp) != v:t_dict
      echoerr "error: argument invalid."
      return
   endif
   call extend(s:session, tmp, "force")
endfunction
function s:get_all_files() " {{{1
   let path = s:session['path']
   if path[len(path) - 1] != '/'
      let path .= '/'
   endif
   let list = glob(path . '*', v:false, v:true)
   return list
endfunction
function s:get_session_list() " {{{1
   " make it session-object list
   " ex. [ 'session', 'session.quickfix', 'session.winpos' ]
   "  -> [ { 'name': 'session', 'quickfix': 1, 'winpos': 1 } ]
   let files = <sid>get_all_files()
endfunction

" }}}1

finish " {{{1


function! session#session(...)
   " smoke call, this is short cut
   if a:0 == 0
      call session#session(g:session.smoker)
      return
   endif
   " banker alive?
   if !session#alive()
      echo 'error: session-banker was dead. - session.vim'
      return
   endif
   " call make or load?
   let type = session#gettype(a:1)
   if type == 'make'
      call session#make(a:000[1:])
      return
   elseif type == 'load'
      call session#load(a:000[1:])
      return
   elseif type == 'list'
      call session#list()
      return
   elseif type == 'error'
      echo 'ERROR: type is wrong. - session.vim'
      return
   else
      echo 'ERROR: error occurred. - session.vim'
      return
   endif
endfunction

function! session#alive()
   let path = expand(g:session.banker)
   if isdirectory(path)
      return v:true
   endif
   if glob(path) != ''
      return v:false
   endif
   if exists('*mkdir')
      call mkdir(path, 'p')
   endif
   return isdirectory(path)
endfunction

function! session#gettype(type)
   if a:type == ''
      return 'error'
   endif
   if session#in(a:type, g:session.topt.make)
      return 'make'
   endif
   if session#in(a:type, g:session.topt.load)
      return 'load'
   endif
   if session#in(a:type, g:session.topt.list)
      return 'list'
   endif
   return 'error'
endfunction

function! session#in(target, list)
   if type(a:list) != v:t_list
      " argument error
      return v:false
   endif
   for item in a:list
      if a:target ==? item
         return v:true
      endif
   endfor
   return v:false
endfunction

function! session#make(args)
   let name = session#getname(a:args)
   if !session#makable(name)
      echo 'error: permission denied. cannot make session file. -session.vim'
      return
   endif
   let path = expand(g:session.banker . name)
   execute 'mksession! ' . path
   if g:session.viminfo
      let vname = name . '.viminfo'
      if session#makable(vname)
         let path = expand(g:session.banker . vname)
         execute 'wviminfo! ' . path
      else
         echo 'error: permission denied. cannot make viminfo file. -session.vim'
      endif
   endif
   if g:session.quickfix
      let qname = name . '.quickfix'
      if session#makable(qname)
         let path = expand(g:session.banker . qname)
         let qflist = getqflist()
         for qf in qflist
            let qf.filename = fnamemodify(bufname(qf.bufnr), ':p')
            unlet qf.bufnr
         endfor
         call map(qflist, 'string(v:val)')
         call writefile(qflist, path)
      else
         echo 'error: permission denied. cannot make quickfix file. -session.vim'
      endif
   endif
   echo 'code: make session file is complete! -session.vim'
endfunction

function! session#load(args)
   let name = session#getname(a:args)
   if !session#exist(name)
      echo 'error: cannot read session file. -session.vim'
      return
   endif
   if !session#loadable(name)
      echo 'error: permission denied. cannot load session file. -session.vim'
      return
   endif
   let path = expand(g:session.banker . name)
   execute 'source ' . path
   if g:session.viminfo
      let vname .= '.viminfo'
      if session#loadable(vname)
         let path = expand(g:session.banker . vname)
         execute 'rviminfo! ' . path
      else
         echo 'error: permission denied. cannot load viminfo file. -session.vim'
      endif
   endif
   if g:session.quickfix
      let qname = name . '.quickfix'
      if session#loadable(qname)
         let path = expand(g:session.banker . qname)
         let qflist = readfile(path)
         call map(qflist, 'eval(v:val)')
         call setqflist(qflist)
      else
         echo 'error: permission denied. cannot load quickfix file. -session.vim'
      endif
   endif
   echo 'code: load session file is complete! -session.vim'
endfunction

function! session#getname(args)
   if type(a:args) != v:t_list
      " argument error
      return g:session.defaultname
   endif
   if len(a:args) == 0
      " name wasnt defined
      return g:session.defaultname
   endif
   return a:args[0]
endfunction

function! session#exist(name)
   let path = expand(g:session.banker . a:name)
   return glob(path) != ''
endfunction

function! session#makable(name)
   let path = expand(g:session.banker . a:name)
   return glob(path) == '' || filewritable(path)
endfunction
function! session#loadable(name)
   let path = expand(g:session.banker . a:name)
   return filereadable(path)
endfunction

function! session#list()
   let path = expand(g:session.banker) . '*'
   let spath = glob(path, v:false, v:true)
   call filter(spath, 'v:val !~# ".*\.quickfix"')
   call filter(spath, 'v:val !~# ".*\.viminfo"')
   call map(spath, 'fnamemodify(v:val, ":t")')
   for s in spath
      echo s
   endfor
endfunction


" vim: set ts=3 sts=3 sw=3 et tw=0 fdm=marker :
