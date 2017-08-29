set encoding=utf-8
scriptencoding utf-8

" my vimscript files {{{
for v in split(expand('$VIM/customize/*.vim'), "\n")
    execute('source ' . v)
endfor
for v in split(expand('$VIM/customize/line_of_magician/*.vim'), "\n")
    execute('source ' . v)
endfor
for v in split(expand('$VIM/customize/pineapple/*.vim'), "\n")
    execute('source ' . v)
endfor
" yule riot zit
for v in split(expand('$VIM/customize/yuleriotzit/*.vim'), "\n")
    execute('source ' . v)
endfor
source $VIM/customize/session_x/session_x.vim
" }}}

set number
set relativenumber

set wrap!
set display=lastline

autocmd BufRead * set textwidth=0

set autoindent
set smartindent

set autochdir

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

set encoding=utf-8
set fileencodings=utf-8,cp932,ucs-2,utf-16le,euc-jp,iso-2022-jp,ucs-2le
set fileformats=unix,dos,mac

set noundofile

set backup
set backupdir=C:\bak~

set path+=$VIM
set path+=$VIM\customize\**

set ignorecase
set smartcase
set infercase

set nrformats=

set foldmethod=marker

set cryptmethod=blowfish2

set cursorline
set formatoptions=q
set noswapfile

set scrolloff=3
set sidescroll=1
set sidescrolloff=1

set path+=$HOME\AppData\Local\Programs\Python\Python35

syntax on

au BufRead,BufNewFile *.cshtml  set filetype=html

let g:netrw_nogx = 1 " disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" reset setting when gui start
set visualbell
set t_vb=

" over write gvimrc
set mouse=n

set splitbelow
set splitright

set noautoread

set conceallevel=2
set concealcursor=nvic

" visiblazation some characters {{{
augroup invisibleZenNTab
    autocmd!
    autocmd BufWinEnter * call SyntaxZenNTab()
augroup END
function! SyntaxZenNTab()
    if &filetype == 'jax'
        " TODO: 調査　効果なし
        call clearmatches()
        setlocal ts=8 sts=8 sw=8 et
        return
    endif
    if exists("g:quicksilver_cat")
        syntax match ZenkakuSpace /　/ conceal cchar=┿ " 全角スペース
        highlight Tab term=reverse gui=undercurl guisp=#80a0ff
        match Tab /	/
        " : and ;
        highlight Colon term=bold gui=bold guifg=#86b781
        highlight Semicolon term=bold gui=bold guifg=#d67388
        call matchadd('Colon', '\U\zs:')
        call matchadd('Semicolon', ';')
        " , and .
        highlight Comma term=none gui=none guifg=#c2f88f
        highlight Period term=none gui=none guifg=#e2d7ff
        call matchadd('Comma', ',')
        call matchadd('Period', '\.')
        set ts=4 sts=4 sw=4 et
    endif
endfunction
" }}}

set winaltkeys=no

" visual-mode search {{{
" refrence by Practical Vim TIP 86
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V'. substitute(escape(@s, a:cmdtype. '\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
" }}}

" argdo on quickfix-list {{{
" practical vim tip96
" https://github.com/nelstrom/vim-qargs
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
" }}}

" input control character {{{
" :help i_CTRL-V :help i_CTRL-V_digit
command! -nargs=? CCI call ControlChatacterInput(<f-args>)
function! ControlChatacterInput(...)
  if a:0 >= 1
      " utf16 dictionary {{{
      " ref https://ja.wikipedia.org/wiki/Unicode%E4%B8%80%E8%A6%A7_0000-0FFF
      let dic = {"tab": "0009", "ht": "0009", "horizontaltab": "0009",
                  \"vt": "000b", "verticaltab": "000b",
                  \"en": "005c", "yen": "005c", "backslash": "005c",
                  \"under": "005f", "underline": "005f", "underscore": "005f",
                  \"childa": "007e", "tilde": "007e", "til": "007e",
                  \"exclamation": "0021",
                  \"question": "003f",
                  \"dquote": "0022", "doublequotation": "0022",
                  \"squote": "0027", "singlequotation": "0027",
                  \"bquote": "02bd", "backquotation": "02bd",
                  \"sharp": "0023", "pound": "0023",
                  \"doller": "0024",
                  \"percent": "0025",
                  \"and": "0026", "ampersand": "0026",
                  \"vline": "007c", "verticalline": "007c",
                  \"equal": "003d"
                  \}
      " }}}
      if has_key(dic, tolower(a:1))
          call feedkeys("a\<C-v>u" . dic[a:1] . "\<Esc>")
      else
          echo a:1 . ' is not in dictioanry'
      endif
  else
      echo "no pronoun"
  end
endfunction
" }}}

" netrw config {{{
augroup MyNetrwConfig
    autocmd! MyNetrwConfig
    autocmd FileType netrw let netrw_open = timer_start(100, 'NetrwEnter', {'repeat': 1})
augroup END
function! NetrwEnter(timer)
    if &filetype == 'netrw'
        setlocal buftype=nofile
    else
        set buftype&
    endif
endfunction
" }}}

" put filename {{{
command! -nargs=* Put :call g:MyPut(<f-args>)
command! Putme :call g:MyPut('%:r')
command! PutMe :call g:MyPut('%:r')
function! g:MyPut(expr) abort
    " ex: Put %:r
    let _winview = winsaveview()

    put =expand(a:expr)
    keepjumps call cursor(line('.') - 1, 0)
    keepjumps join

    let _lastcol = col('$') - 2
    let _winview['col'] = _lastcol
    let _winview['curswant'] = _lastcol
    call winrestview(_winview)
endfunction
" }}}

" python indent {{{
augroup PythonSetting
    autocmd!
    autocmd FileType python,py setlocal ts=8 sts=3 sw=3 et
augroup END
" }}}

" vimscript run soon {{{
"nnoremap <Plug>Exl call ExecuteLine()
command! ExL call ExecuteLine()
function! ExecuteLine()
    let l:cmd = getline('.')
    exec l:cmd
endfunction
" }}}


