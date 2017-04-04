""""""""""""""""""""""""""""" customize of me """""""""""""""""""""""""""""
" TODO: ここになんか描く
""""""""""""""""""""""""""""" customize of me """""""""""""""""""""""""""""

" key mapping
source $VIM\customize\map.vim
" vim-plug option <<dont use>>
"source $VIM\customize\plugs.vim
" rogue option
source $VIM\customize\rogueOptions.vim
" session_x
source $VIM\customize\session_x\session_x.vim
" syntax
"source $VIM\customize\addSyntax.vim
" chatwork
source $VIM\customize\chatwork.vim
" chess game
source $VIM\customize\chess.vim
" statusline
source $VIM\customize\statusline.vim
" quicksilver
source $VIM\customize\quicksilver.vim
" secret :set path+=C:\dev\会社名\プロジェクト名\** etc.
source $VIM\customize\secret.vim
" pineapple
runtime! $VIM\customize\pineapple\*.vim

" ?E?B????hrE?T?C?Ya??̕ύX
"if has("gui_running")
"    set lines=30 columns=100
"endif

" ?s??P??\??
set number
set relativenumber

" ?܂M?Ԃ?i?ĕ\??????
set wrap!
set display=lastline

" ???D?ŃC???f???g???????
set autoindent

" ?????ŃJ?????g?f?B???N?g?.]?ύX????
" ??j????A???ꂪ?I?????Ɠ????Ȃ??v???O?C??'??????͗l
set autochdir

" Tab => Space Conversion
set tabstop=4
set expandtab
set shiftwidth=4

" ???.????R?[?h
set encoding=utf-8
set fileencodings=utf-8,cp932,ucs-2,utf-16le,euc-jp,iso-2022-jp,ucs-2le
set fileformats=unix,dos,mac

" undo file(*.un~) ?����??ɍ??点?Ȃ?
set noundofile

" back up file(*.*~) ??℅???点??
set backup
set backupdir=C:\bak~

" path ???ݒ肵?Afind?R?}???h???֗ィ??ɂ???
set path+=$VIM\customize\**

" ???����??񂪏??????̏ꍇ?͑啶?????????̋??ʂ����Ȃ?
set ignorecase
" ???����????ɑ啶?????܂܂??Ă????Ȃ??A???ʂ???
set smartcase

" Vim ???Ő??l??10?i???ň??? (007++ == 010) => (007++ == 008)
set nrformats=

" ?܂?????
set foldmethod=marker

" ?Í??A???S???Y??
set cryptmethod=blowfish2

" detective after
set cursorline
set textwidth=0
set formatoptions=q
set noswapfile

" ?J???[?X?L?[?}
colorscheme frozendaiquiri

" ?\???n?C???C?g
syntax on

" ?
au BufRead,BufNewFile *.cshtml  set filetype=cshtml

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" SORROW: 壊れてしまった文字コードに惜別の赤いバラを🌹🎵

" use flash instead beep
set visualbell
set t_vb=

" 腱鞘炎 don't forgot Tendovaginitis
set mouse=n " resetting in gvimrc | this line is needless

" intro を非表示に
"set shortmess+=I

""" schedule
autocmd VimEnter * nested if @% == '' | call s:schedule_intro() | endif
function! s:schedule_intro()
    let s:scdl_content = []
    " TODO: そのうち googleカレンダーと同期したい
    "       また、スケジュールの部分を別ファイルに分離する
    call add(s:scdl_content, { 'date': localtime(), 'message': 'test' })
    call add(s:scdl_content, { 'date': localtime(), 'message': 'localtime' })
    call add(s:scdl_content, { 'date': 1501013200, 'message': '歯科検診' }) " 2017/8/1
    call add(s:scdl_content, { 'date': 1493478000, 'message': 'カマロン記念日' }) " 2017/4/30
    call add(s:scdl_content, { 'date': localtime()+60*60*24, 'message': '一日後' })

    """ schedule intro. reference by vim-splash
    " SORROW: …… vim-splashを参考にしたはず。……一応はね
    try
        hide enew
        setlocal buftype=nofile nowrap nolist nonumber norelativenumber bufhidden=wipe
        call setline(1, '== schedule ==') | 1center
        let s:now = localtime()
        for s in s:scdl_content
            if s['date'] < s:now + 60*60*24*7 " 一週間前には表示
                call append(line("."), strftime("%Y/%m/%d", s['date']) . ' ' . s['message'])
            endif
        endfor
        redraw
        " SORROW: 闇の女王の眼差しに魅入られて、光の道は閉ざされた
        "         dont escape from dark! let escape character!
        let char = getchar()
        silent execute 'enew'
        call feedkeys(char)
    catch
        echon 'error: intro schedule'
    endtry
endfunction

" quicksilver_cat
let g:quicksilver_cat = 1
if exists("g:quicksilver_cat")
    " u enable setting, 2byte character 2 [eol], b4 GUI start
    set list
    set listchars=eol:┸,trail:~,extends:>,precedes:<
endif

" quicksilver_cat
set conceallevel=2
set concealcursor=nvic
augroup invisibleZenNTab
    autocmd! invisibleZenNTab
    autocmd BufWinEnter * call SyntaxZenNTab()
augroup END
function! SyntaxZenNTab()
    if exists("g:quicksilver_cat")
        " jax(help)ファイルではconcealしてほしくないけどなぁ……
        " SORROW: 誰かがconcealは微妙って言っていた
        syntax match ZenkakuSpace /　/ conceal cchar=┿ " 全角スペース
        syntax match Tab /	/ conceal cchar=╂ " Tab
    endif
endfunction


