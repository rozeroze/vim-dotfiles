" rozeroze's .vimrc
" header {{{1
" author {{{2
" Author: rozeroze
" Mail: rosettastone1886@gmail.com
" }}}2
" rules {{{2
" Names: {{{3
"   * varables:
"     - let s:script_local = 'snake_case'
"     - let b:buffer_local = 'snake_case'
"     - let g:global_scope = 'snake_case'
"     - let no_designation = 'snake_case'
"     - let $ENVIRONMET_VAR = 'UPPER_SNAKE'
"   * function:
"     - function! s:script_func()
"          echo 'snake_case'
"       endfunction
"     - function! g:GlobalFunc()
"          echo 'PascalCase'
"       endfunction
"     - function! s:FuncWithCommand()
"          echo 'same as command-name'
"          " ex) command Test :call <sid>Test()
"          "     function s:Test()
"          "        echo 'this is test function'
"          "     endfunction
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
" Coding: {{{3
"   coding .vimrc, .gvimrc or vim-file
"     indent is not tab, it is space.
"     number-of-spaces is 3.
"     character-set is utf-8, nobomb
" KeyCodes: {{{3
"   help 'key-notation' / 'key-codes', 'keycodes'
"     use lower case
"        bad-case => <Space>
"        bad-case => <CR>
"       good-case => <space>
"       good-case => <cr>
" }}}2
" at first {{{2
set nocompatible
set encoding=utf-8
scriptencoding utf-8
let s:is_win  = has('win32')
let s:is_mac  = has('mac')
let s:is_unix = has('unix')
if s:is_win
   " runtimepath ~/vimfiles -> ~/.vim
   let &runtimepath = substitute(&runtimepath,
            \ escape($HOME, '\') . '/vimfiles',
            \ escape($HOME, '\') . '/.vim',
            \ 'g')
endif
set path+=$HOME\.vim
set packpath+=$HOME\.vim
let g:user = {}
let g:user.name = 'rozeroze'
let g:user.mail = 'rosettastone1886@gmail.com'
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
set splitbelow
set splitright
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
set ignorecase
set smartcase
set infercase
set nrformats=
set formatoptions=q
set winaltkeys=no
set cryptmethod=blowfish2
" vim action {{{2
set fileencodings=utf-8,ucs-2,ucs-2le,utf-16,utf-16le,euc-jp,cp932
set fileformats=unix,dos,mac
set noundofile
set noswapfile
set updatecount=0
set backup
set backupdir=C:\bak~
set noautoread
set maxmem=2000000
set maxmempattern=1000
set maxmemtot=2000000
set visualbell
set t_vb=
set noerrorbells
" }}}1

" mappings {{{1
" normal-mode <space>* {{{2
nnoremap <space>w :<c-u>update<cr>
nnoremap <space><space>w :<c-u>write!<cr>
nnoremap <space>q :<c-u>quit<cr>
nnoremap <space><space>q :<c-u>quit!<cr>
nnoremap <space><space><space>q :<c-u>quitall!<cr>
nnoremap <space>4 <s-$>
nnoremap <space>5 <s-%>
nnoremap <space>; :
" searches {{{2
nnoremap / /\v
nnoremap ? ?\v
nnoremap <silent> // :<c-u>let v:hlsearch = !v:hlsearch<cr>
nnoremap <silent> * :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> # :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> g* :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
nnoremap <silent> g# :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
" indent-change {{{2
vnoremap <silent> < <gv
vnoremap <silent> > >gv
" }}}1

" TODO: divide
" plugin and package {{{1
" enable/disable {{{2
let g:loaded_intro_schedule = 1
let g:loaded_investor = 1
let g:loaded_chess = 1
let g:loaded_chessboard = 1
let g:loaded_quickfixdo = 1
"let g:loaded_rolling_color = 1
let g:loaded_rozeonline = 1
let g:loaded_dotgraph = 1
let g:loaded_keylogger = 1
let g:loaded_mastercancel = 1
let g:loaded_lazystep = 1
let g:loaded_slum = 1
"let g:loaded_writeorders = 1
let g:loaded_colorschemer = 1
let g:loaded_ruler = 1
"let g:loaded_life = 1
"let g:loaded_vimdb = 1
" variables {{{2
" moveme
let g:moveme = {}
let g:moveme.per_line = 1
let g:moveme.per_column = 2
let g:moveme.ascii_enable = v:true
let g:moveme.ascii_file = expand('$HOME/.vim/pack/packages/opt/moveme/plugin/moveme.ascii.txt')
" session
let g:session = {}
let g:session.quickfix = v:true
" chiffon
let g:chiffon = {}
let g:chiffon.default = 'anz'
let g:chiffon.anz = 'あんずもじ等幅:h12:cSHIFTJIS:qDRAFT'
let g:chiffon.misaki = '美咲ゴシック:h12:cSHIFTJIS:qDRAFT'
let g:chiffon.myrica = 'MyricaM_M:h12:b:cSHIFTJIS:qDRAFT'
" chatwork
if filereadable(expand('$HOME/.vim/plugin/chatwork/chatwork.json'))
   let g:chatwork = json_decode(join(readfile(expand('$HOME/.vim/plugin/chatwork/chatwork.json'))))
endif
" load {{{2
" plugins
for spath in split(glob($HOME . '/.vim/plugins/*'), '\n')
   if spath !~# '\~$' && isdirectory(spath)
      if !exists('g:loaded_' . split(spath, '\\')[-1])
         "let &runtimepath .= ',' . spath
      endif
   end
endfor
for spath in split(glob($HOME . '/.vim/after/plugins/*'), '\n')
   if spath !~# '\~$' && isdirectory(spath)
      if !exists('g:loaded_' . split(spath, '\\')[-1])
         "let &runtimepath .= ',' . spath
      endif
   end
endfor
" settings
for spath in split(glob($HOME . '/.vim/settings/*.vim'), '\n')
   if !exists('g:loaded_' . fnamemodify(spath, ':t:r'))
      execute 'source ' . spath
   endif
endfor
unlet spath
" packages
" matchit {{{3
" ex: # is cursor
"   <div c#ass="start">
"     <span class="middle">if you put '%' button</span>
"   </div>
" rem: cursor is moved match-tag
"   <div class="start">
"     <span class="middle">cursor moves to match-tag</span>
"   <#div>
packadd matchit
" expandspace {{{3
" interchange multibyte-space to spaces when inserting it
" for example, 'expandtab' is convert <tab> to spaces.
" likewise, this convert <multibyte-space> to spaces.
packadd expandspace
" moveme {{{3
" :Moveme you can move the Vim
"   move command:
"     - h move left
"     - j move down
"     - k move up
"     - l move right
"   resize command:
"     - H smallen number-of-columns
"     - J enlarge number-of-lines
"     - K smallen number-of-lines
"     - L enlarge number-of-columns
"     - < smallen columns and lines
"     - > enlarge columns and lines
packadd moveme
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

" " }}}1

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
" }}}1

" vim: set ts=3 sts=3 sw=3 et fdm=marker :
