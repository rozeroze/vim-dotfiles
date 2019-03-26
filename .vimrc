" rozeroze's .vimrc
" header {{{1
" author {{{2
" Author: rozeroze
" Mail: rosettastone1886@gmail.com
" }}}2
" rules {{{2
" Names: {{{3
"   * variables:
"     - let s:script_local = 'snake_case'
"     - let b:buffer_local = 'snake_case'
"     - let g:global_scope = 'snake_case'
"     - let no_designation = 'snake_case'
"     - let $ENVIRONMET_VAR = 'UPPER_SNAKE'
"   * command:
"     - command! DefineCommand :echo 'PascalCase'
"   * function:
"     - function! s:script_func()
"          echo 'snake_case'
"       endfunction
"     - function! g:GlobalFunc()
"          echo 'PascalCase'
"       endfunction
"     - function! s:FuncWithCommand()
"          echo 'same as command-name'
"          " ex) | command Test :call <sid>Test()
"          "     | function s:Test()
"          "     |    echo 'if wrapping command is exist,'
"          "     |    echo 'function-name follow the command-name-rule'
"          "     | endfunction
"       endfunction
" SetOptions: {{{3
"   option-name must be full
"        bad-case => set nu
"       good-case => set number
"   and set-command is same it
"        bad-case => se number
"        bad-case => setl number
"       good-case => set number
"       good-case => setlocal number
"   when set-default, use '&'
"       good-case => set number&
"   when toggle opt, use '!'
"        bad-case => set invnumber
"       good-case => set number!
"   when set-args, use '='
"        bad-case => set tabstop:4
"       good-case => set tabstop=4
"   set multiple-options, no-args ahead
"        bad-case => set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
"       good-case => set expandtab tabstop=4 softtabstop=4 shiftwidth=4
"   and over 80 characters, use shortening-name
"        bad-case => set number relativenumber cursorline cursorcolumn ...
"       good-case => set nu rnu cul cuc so=0 siso=0
"   however if on that time, it is better what divide lines
"     better-case => set number relativenumber
"                    set cursorlien cursorcolumn
"                    set scrolloff=0 sidescrolloff=0
"   only modeline is an exceptions, it is always shortening-name
"        bad-case => /* vim: set foldmethod=marker foldlevel=1 */
"       good-case => /* vim: set fdm=marker fdl=1 */
" Coding: {{{3
"   coding .vimrc, .gvimrc or vim-file
"     using indent with space, not tab
"     number-of-spaces is 3.
"     character-set is utf-8, nobomb
"   when editing project-files, undering the project-rules
" KeyCode: {{{3
"   help 'key-notation' / 'key-codes', 'keycodes'
"     use lower case
"        bad-case => nnoremap <Space>s :call <SID>Save('%')<CR>
"       good-case => nnoremap <space>s :call <sid>Save('%')<cr>
"   when script coding, almost use single-quotes
"     :let hello = 'Hello World!'
"   when coding key-codes, use double-quotes
"     :let leader = ' '        " it's a little hard to make understand
"     :let leader = "\<space>" " it's a explicit!
"   there are some case include quotes
"     :echo ''
"     :echo ""
" Lines: {{{3
"   coding vim-script
"   * make new line as much as possible
"        bad-case => if status | call something() | endif
"       good-case => if status
"                       call something()
"                    endif
"        bad-case => for item in list | call something(item) | endfor
"       good-case => for item in list
"                       call something(item)
"                    endfor
"   * also is it necessary to short-liner, you can it
"                 => for item in list
"                       call something(item) | endfor
"   * case of what a similar sentence was continued, you can one-liner
"                 => if flag['a'] | call valid(flag, 'a') | endif
"                    if flag['b'] | call valid(flag, 'b') | endif
"
" }}}2
" at first {{{2
set nocompatible
set encoding=utf-8
scriptencoding utf-8
let s:is_win  = has('win32')
let s:is_mac  = has('mac')
let s:is_unix = has('unix')
let s:enable_package = has('packages')
let s:enable_timer   = has('timers')
if s:is_win
   " runtimepath ~/vimfiles -> ~/.vim
   let &runtimepath = substitute(&runtimepath,
            \ escape($HOME, '\') . '/vimfiles',
            \ escape($HOME, '\') . '/.vim',
            \ 'g')
endif
set path+=$HOME\.vim
if s:enable_package
   set packpath+=$HOME\.vim
endif
if !exists('g:user')
   let g:user = {}
   let g:user.name = 'rozeroze'
   let g:user.mail = 'rosettastone1886@gmail.com'
   function g:user.comment(...) abort
      return a:0 ? printf(&commentstring, printf('%s <%s>', g:user.name, g:user.mail))
               \ : printf('%s <%s>', g:user.name, g:user.mail)
   endfunction
endif
if !exists('g:date')
   let g:date = {}
   function! g:date.today()
      return strftime('%Y%m%d')
   endfunction
   function! g:date.now()
      return strftime('%Y/%m/%d %H:%M')
   endfunction
endif
" }}}2
" }}}1

" set-options {{{1
" screen display {{{2
set number
set relativenumber
set nowrap
set display=
set cursorline
set nocursorcolumn
set scrolloff=3
set sidescroll=1
set sidescrolloff=7
set conceallevel=2
set concealcursor=nvic
set synmaxcol=1000
set foldmethod=marker
set nosplitbelow
set nosplitright
" assistantce {{{2
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
set autoindent
set smartindent
set iminsert=0
set imsearch=0
set virtualedit=block
set ignorecase
set smartcase
set infercase
set nrformats=
set formatoptions=roqnMj
set winaltkeys=no
set viminfo=
set cryptmethod=blowfish2
" vim action {{{2
set fileencodings=utf-8,ucs-2,ucs-2le,utf-16,utf-16le,euc-jp,cp932
set fileformats=unix,dos,mac
set noundofile
set noswapfile
set updatecount=0
set backup
set backupdir=~/bak,~/tmp
set noautoread
set maxmem=2000000
set maxmempattern=1000
set maxmemtot=2000000
set tabpagemax=100
set visualbell
set t_vb=
set noerrorbells
" }}}1

" plugins {{{1
" chiffon {{{2
let g:chiffon = {}
let g:chiffon.default = { 'font': 'あんずもじ等幅:h12:cSHIFTJIS:qDRAFT' }
let g:chiffon.win = { 'font': 'Consolas:h12:b', 'wide': 'HGｺﾞｼｯｸE:h12' }
let g:chiffon.mac = { 'font': 'Osaka－等幅:h12' }
let g:chiffon.anz = { 'font': 'あんずもじ等幅:h12:cSHIFTJIS:qDRAFT' }
let g:chiffon.misaki = { 'font': '美咲ゴシック:h12:cSHIFTJIS:qDRAFT' }
let g:chiffon.myrica = { 'font': 'MyricaM_M:h12:b:cSHIFTJIS:qDRAFT' }
" }}}1

if s:enable_package
   " packages {{{1
   " matchit {{{2
   silent! packadd matchit
   " expandspace {{{2
   silent! packadd expandspace
   " moveme {{{2
   let g:moveme = {}
   let g:moveme.points = 10
   let g:moveme.lines = 1
   let g:moveme.columns = 2
   let g:moveme.ascii_enable = v:true
   let g:moveme.ascii_file = expand('$HOME/.vim/pack/packages/opt/moveme/plugin/moveme.ascii.txt')
   silent! packadd moveme
   " session {{{2
   let g:session = {}
   let g:session.quickfix = v:true
   " chatwork {{{2
   if filereadable(expand('$HOME/.vim/.chatwork'))
      let g:chatwork = json_decode(join(readfile(expand('$HOME/.vim/.chatwork'))))
   endif
   " }}}1
endif

" settings {{{1
let g:rozerc = {}
" preset-load {{{2
"let g:loaded_chess = 1
"let g:loaded_chessboard = 1
"let g:loaded_quickfixdo = 1
"let g:loaded_lazystep = 1
" source {{{2
"for spath in split(glob($HOME . '/.vim/settings/*.vim'), '\n')
"   if !exists('g:loaded_' . fnamemodify(spath, ':t:r'))
"      execute 'source ' . spath
"   endif
"endfor
"unlet spath
" local-rc loader {{{2
command! -nargs=+ Rozerc :call <sid>Rozerc(<args>)
function! s:Rozerc(name, ...)
   if type(a:name) != v:t_string
      echoerr "argument error: the first argument for Rozerc must be string-value"
      return
   endif
   if a:0 > 1
      echoerr "argument error: Rozerc cannot has over 3 arguments"
      return
   endif
   let file = expand('$HOME/.vim/settings/' . a:name . '.vim')
   if !filereadable(file)
      echomsg printf('%s is denied', a:name)
      return
   endif
   if a:0 == 1
      let g:rozerc[a:name] = a:1
   endif
   execute 'source ' . file
endfunction
" loads {{{2
"Rozerc map
" TODO: investigate settings enable/disable and coding rozerc here
" }}}1

" mappings {{{1
let mapleader = "\<space>"
" normal-mode <leader> {{{2
nnoremap <leader>w :<c-u>update<cr>
nnoremap <leader><leader>w :<c-u>write!<cr>
nnoremap <leader><leader><leader>w :<c-u>set buftype& <bar> w<cr>
nnoremap <leader>q :<c-u>quit<cr>
nnoremap <leader><leader>q :<c-u>quit!<cr>
nnoremap <leader><leader><leader>q :<c-u>quitall!<cr>
nnoremap <leader>4 <s-$>
nnoremap <leader>5 <s-%>
nnoremap <leader>; :
" searches {{{2
nnoremap <silent> // :<c-u>let v:hlsearch = !v:hlsearch<cr>
nnoremap <silent> *  :<c-u>let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> #  :<c-u>let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> g* :<c-u>let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
nnoremap <silent> g# :<c-u>let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
" rendering {{{2
nnoremap <silent> <left>  :normal! zh<cr>
nnoremap <silent> <down>  <c-e>
nnoremap <silent> <up>    <c-y>
nnoremap <silent> <right> :normal! zl<cr>
" plugin-mapper <plug> {{{2
nmap <nowait><unique> <leader>m <plug>MoveMe
" }}}1

" languages {{{1
" python {{{2
if s:is_win
   if isdirectory(expand('$HOME\AppData\Local\Programs\Python\Python35'))
      set path+=$HOME\AppData\Local\Programs\Python\Python35
      set pyxversion=3
   endif
endif
" }}}1

" functions {{{1
" test RW {{{2
function! RW(test, ...)
   echo a:test
   if a:0 > 0
      echo a:1
   endif
endfunction
" test Blink {{{2
function! Blink()
   let v:hlsearch = !v:hlsearch
   redraw
   sleep 50ms
endfunction
" test Counter {{{2
function! Counter()
   let counter = {}
   let l:count = 0
   function! counter.up() closure
      let l:count += 1
      return l:count
   endfunction
   function! counter.down() closure
      let l:count -= 1
      return l:count
   endfunction
   function! counter.print() closure
      return l:count
   endfunction
   return counter
endfunction
" }}}1

" commands {{{1
" open explore on windows {{{2
if s:is_win
   " overwrite command 'Exp' what defined by netrw
   command! Exp :call <sid>Exp()
   function! s:Exp()
      if isdirectory(expand('%:p'))
         silent! execute 'cd %:p'
      elseif expand('%') != ''
         silent! execute 'cd %:h'
      else
         " no-name buffer etc...
      endif
      silent! execute '!start '
   endfunction
endif
" diffstart where on current tab page {{{2
command! Diff :call <sid>Diff()
function! s:Diff()
   if &diff
      windo diffoff
   else
      windo diffthis
   endif
endfunction
" echo arguments {{{2
command! -nargs=+ Arg :call <sid>Arg(<args>)
function! s:Arg(...)
   echo a:000
endfunction
" lscd {{{2
command! Lscd :call <sid>Lscd()
function! s:Lscd()
   nnoremap <nowait><buffer> : :call <sid>LscdExec(input('vim-lscd: '))<cr>
endfunction
function! s:LscdExec(command)
   "call append(0, a:command)
endfunction
" }}}1

" vim: set et ts=3 sts=3 sw=3 fdm=marker fdl=1 :
