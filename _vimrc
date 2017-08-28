""""""""""""""""""""""""""""" customize of me """""""""""""""""""""""""""""
" TODO: ここになんか描く
""""""""""""""""""""""""""""" customize of me """""""""""""""""""""""""""""

"runtime! C:\vim\*.vim
"runtime! C:/vim/*.vim
" SORROW: runtimeだと、読み込まれない……？
" (((; 'Д')Ξ⊃) 'Д),;'. なぜだっ！
for v in split(expand('$VIM/customize/*.vim'), "\n")
    "source v
    "echo type(v)
    " source 'C:/vim/customize/map.vim' はエラー（文字列として渡されている？）
    execute('source ' . v)
endfor

" SORROW: ラインの魔術師を呼べない
"runtime! $VIM\customize\theLineOfTheMagician\*.vim
" SORROW: cannot eat pineapple! why? (p'v')=p)'Д) OUCH!
"runtime! $VIM\customize\pineapple\*.vim
for v in split(expand('$VIM/customize/theLineOfTheMagician/*.vim'), "\n")
    execute('source ' . v)
endfor
for v in split(expand('$VIM/customize/pineapple/*.vim'), "\n")
    execute('source ' . v)
endfor
" yule riot zit
for v in split(expand('$VIM/customize/yuleRiotZit/*.vim'), "\n")
    execute('source ' . v)
endfor
" session make
source $VIM/customize/session_x/session_x.vim

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

" 自動改行
"set textwidth=0
autocmd BufRead * set textwidth=0

" ???D?ŃC???f???g???????
set autoindent
set smartindent

" ?????ŃJ?????g?f?B???N?g?.]?ύX????
" ??j????A???ꂪ?I?????Ɠ????Ȃ??v???O?C??'??????͗l
set autochdir

" Tab => Space Conversion
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" ???.????R?[?h
set encoding=utf-8
set fileencodings=utf-8,cp932,ucs-2,utf-16le,euc-jp,iso-2022-jp,ucs-2le
set fileformats=unix,dos,mac

" undo file(*.un~) ???ɍ??点?Ȃ?
set noundofile

" back up file(*.*~) ??℅???点??
set backup
set backupdir=C:\bak~

" path ???ݒ肵?Afind?R?}???h???֗ィ??ɂ???
set path+=$VIM
set path+=$VIM\customize\**

" ???��??񂪏??????̏ꍇ?͑啶?????????̋??ʂⵂȂ?
set ignorecase
" ???��????ɑ啶?????܂܂??Ă????Ȃ??A???ʂ???
set smartcase
" reference by Practical Vim TIP 111
set infercase

" Vim ???Ő??l??10?i???ň??? (007++ == 010) => (007++ == 008)
set nrformats=

" ?܂?????
set foldmethod=marker

" ?Í??A???S???Y??
set cryptmethod=blowfish2

" detective after
set cursorline
"set cursorcolumn
set formatoptions=q
set noswapfile

" scroll
set scrolloff=3
set sidescroll=1
set sidescrolloff=1

" python setting
set path+=$HOME\AppData\Local\Programs\Python\Python35

" ?J???[?X?L?[?}
if has('gui_running') && !empty(glob('$VIM/vim80/colors/frozendaiquiri.vim'))
    colorscheme frozendaiquiri
else
    colorscheme elflord
endif

" ?\???n?C???C?g
syntax on

" ?
au BufRead,BufNewFile *.cshtml  set filetype=html

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

" split
set splitbelow
set splitright

" autoread
set noautoread


""" intro schedule {{{
"if exists('g:loaded_intro_schedule') | finish | endif
"let g:loaded_intro_schedule = 1
"autocmd VimEnter * nested if @% == '' | call s:schedule_intro() | endif
"function! s:schedule_intro()
"    let s:scdl_content = []
"    " TODO: そのうち googleカレンダーと同期したい
"    "       また、スケジュールの部分を別ファイルに分離する
"    " MEMO: https://github.com/itchyny/calendar.vim が参考になりそう
"    " NOTE: UNIX時間
"    " TODO: UNIX時間に容易に変換できるVimScriptをつくるぞいっ！
"    " SORROW: 起動したのが月曜日の時は『ねえ、月曜日だよ。いまどんな気分？ねぇ、どんな気分？』と出力してはいけない
"    call add(s:scdl_content, { 'date': localtime(), 'message': 'localtime' })
"    "call add(s:scdl_content, { 'date': 1501013200, 'message': '歯科検診' }) " 2017/8/1
"    "call add(s:scdl_content, { 'date': 1502550000, 'message': 'ペルセウス座流星群が極大' }) " 2017/8/13
"    call add(s:scdl_content, { 'date': 1503327600, 'message': '皆既日食（北米方面）' }) " 2017/8/22
"    call add(s:scdl_content, { 'date': 1507042800, 'message': '中秋の名月' }) " 2017/10/4
"    call add(s:scdl_content, { 'date': 1507388400, 'message': '寒露。10月りゅう座流星群が極大' }) " 2017/10/8
"    call add(s:scdl_content, { 'date': 1507561200, 'message': 'アルデバラン食（北日本）。おうし座流星群が極大' }) " 2017/10/10
"    call add(s:scdl_content, { 'date': 1508511600, 'message': 'オリオン座流星群が極大' }) " 2017/10/21
"    call add(s:scdl_content, { 'date': 1510412400, 'message': 'レグルス食。おうし座北流星群が極大' }) " 2017/11/12
"    call add(s:scdl_content, { 'date': 1510930800, 'message': '新月。しし座流星群が極大。なお月明かりの影響がなく好条件' }) " 2017/11/18
"    call add(s:scdl_content, { 'date': 1511449200, 'message': '水星が東方最大離角' }) " 2017/11/24
"    call add(s:scdl_content, { 'date': 1512313200, 'message': '今年最大の満月' }) " 2017/12/4
"    call add(s:scdl_content, { 'date': 1513177200, 'message': 'ふたご座流星群が極大。月明かりの影響が少なく、好条件' }) " 2017/12/14
"    call add(s:scdl_content, { 'date': 1525014000, 'message': 'カマロン記念日' }) " 2018/4/30
"
"    """ schedule intro. reference by vim-splash
"    " SORROW: …… vim-splashを参考にしたはず。……一応はね
"    try
"        hide enew
"        setlocal buftype=nofile nowrap nolist nonumber norelativenumber bufhidden=wipe
"        call setline(1, '== schedule ==') | 1center
"        let s:now = localtime()
"        for s in s:scdl_content
"            if s['date'] < s:now + 60*60*24*90 " 3カ月前には表示
"                call append(line("."), strftime("%Y/%m/%d", s['date']) . ' ' . s['message'])
"            endif
"        endfor
"        redraw
"        " SORROW: 闇の女王の眼差しに魅入られて、光の道は閉ざされた
"        "         dont escape from dark! let escape character!
"        let char = nr2char(getchar())
"        silent execute 'enew'
"        call feedkeys(char)
"    catch
"        echon 'error: intro schedule'
"    endtry
"endfunction
""" }}}

" quicksilver_cat
let g:quicksilver_cat = 1
if exists("g:quicksilver_cat")
    " u enable setting, 2byte character 2 [eol], b4 GUI start
    " ただし、環境による　→　違った
    " 別の環境で構築するときにエンコーディングを'utf-8'に修正すれば動作する
    set list
    set listchars=eol:┸,trail:~,extends:>,precedes:<
    " SORROW: eolでは改行コードの区別まではできないだろう
    " SORROW: <LF>と<CR>と<CRLF>を混在させてくる変態がいる
endif

" quicksilver_cat
set conceallevel=2
set concealcursor=nvic
augroup invisibleZenNTab
    autocmd!
    " NOTE: 環境によってエラーになるイベントか否かが変わる
    " ここも同様に、'utf-8'でエンコーディングしなおせば解決する
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
        " jax(help)ファイルではconcealしてほしくないけどなぁ……
        " SORROW: 誰かがconcealは微妙って言っていた
        syntax match ZenkakuSpace /　/ conceal cchar=┿ " 全角スペース
        "syntax match Tab /	/ conceal cchar=╂ " Tab
        highlight Tab term=reverse gui=undercurl guisp=#80a0ff
        match Tab /	/
        " and other
        " NOTE: match は常に上書きされ、ひとつしか保持できない
        " NOTE: undercurl(波線)は guisp で指定できるのに下線はできない
        "highlight Colon term=underline gui=underline guifg=#d67388
        "highlight Semicolon term=undercurl gui=undercurl guisp=#d67388
        highlight Colon term=bold gui=bold guifg=#86b781
        highlight Semicolon term=bold gui=bold guifg=#d67388
        "match Colon /:/
        "match Semicolon /;/
        call matchadd('Colon', '\U\zs:')
        call matchadd('Semicolon', ';')
        " comma and period
        highlight Comma term=none gui=none guifg=#c2f88f
        highlight Period term=none gui=none guifg=#e2d7ff
        call matchadd('Comma', ',')
        call matchadd('Period', '\.')
        set ts=4 sts=4 sw=4 et
    endif
endfunction

" TODO: rozeroze-search
" LOOK_OVER: help autocmd-events-abc
" autocmd searchAfter * zz " window scroll to state <cursor center>

" altkeys
set winaltkeys=no

" cursor column where is in?
command! CursorWhereIsIn :call s:CursorWhereIsIn()
function! s:CursorWhereIsIn()
    " TODO: get cursor column, and search '{' & '}' that most nearest by the
    " columns. if getting upper line is only '{', get that line at over 1.
    " appeared to statusline that one.
    " ex.
    " foreach (var v in _list) {
    "     // do something
    " #   // # is cursor
    " }
    " NOTE: find out same indent block. over case, you got 'foreach' block.
    " and statusline is '[filename] [status]                            '
    "               \ . '       [block(foreach)] [columnnumber] [line%] '
    " NOTE: 何書いてあるのかよくわからん
    "       日本語入力モードにするのが面倒だったから、英語をフィーリングで書いたことだけは覚えている
    "       おそらく、一番近くのブロックスターター(ex: '{' )を探し出し、その行に移動するのだと思う
endfunction

" refrence by Practical Vim TIP 86
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V'. substitute(escape(@s, a:cmdtype. '\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

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

" 特殊文字　制御文字　ぬうりょく <<入力>>
command! -nargs=? Cvu :call s:ControlVUnicode(<f-args>)
function! s:ControlVUnicode(...)
  " TODO: divide file after
  if a:0 >= 1
      let dic = {"Tab": "0009", "HT": "0009", "VT": "000b", "EN": "00a5", "Under": "005f", "childa": "007e" }
      if has_key(dic, a:1)
          call feedkeys("a\<C-v>u" . dic[a:1] . "\<Esc>")
      else
          echo a:1 . ' is not in dictioanry'
      endif
  else
      echo "no pronoun"
  end
endfunction

"""""""""""""""""""""""""""""""""" netrw """""""""""""""""""""""""""""""""
" escape error, netrw window was changed by outside netrw
" TODO: can't show help
augroup MyNetrwConfig
    autocmd! MyNetrwConfig
    autocmd FileType netrw let netrw_open = timer_start(100, 'NetrwEnter', {'repeat': 1})
augroup END
"autocmd FileType netrw setlocal buftype=nofile " netrw.vim で上書きされてる
" SORROW: どうしようか？ファイルの読み込み順とか調べるの面倒
function! NetrwEnter(timer)
    if &filetype == 'netrw'
        setlocal buftype=nofile
    else
        set buftype&
    endif
endfunction
" NOTE: ftpluginで設定しても、netrw.vimのautocmdでリセットされる？
" ???: 読込順 ftplugin => autocmd FileType netrw
" TODO: netrw.vim の L:11421 fun! s:NetrwInsureWinVars() があやしい
"       ここで buftype を設定できるのでは？
" SORROW: なんだかんだで上手くいった?
"         ちなみにこのコードはnetrw内から次のコマンドでファイルを作成するために
"         おこるエラーの回避を狙っている
"         !type nul > {filename}
"         shell 使ってファイルを作ると、netrwバッファを変更することになるから、
"         閉じるときに『変更が保存されていません』と怒られるのだ
" SORROW: 嘘だっ！ netrw から % と打つだけでファイル作成ができるなんて……
"         未熟だ netrwではファイル作成ができないというデマを信じてしまった
""""""""""""""""""""""""""""""""" /netrw """""""""""""""""""""""""""""""""

" いまのvimrcの状態を取得する
command! WhatStateMyVimrcNow :call s:WhatStateMyVimrcNow()
function! s:WhatStateMyVimrcNow()
    echo '思い付きで適当にコードを足したり、無意味なコメントを積み重ねたり、'
     \ . 'そのうえ整理もしないコードがまともなはずないだろう？'
     \ . 'はっきり言ってあげよう 読めた代物ではない'
endfunction
"autocmd BufEnter _vimrc,_gvimrc :WhatStateMyVimrcNow


command! -nargs=* Put :call g:MyPut(<f-args>)
command! Putme :call g:MyPut('%:r')
command! PutMe :call g:MyPut('%:r')
function! g:MyPut(expr) abort
    " ex: Put %:r
    let _winview = winsaveview()

    put =expand(a:expr)
    keepjumps call cursor(line('.') - 1, 0)
    keepjumps join

    let _lastcol = col('$') - 2 " col($) は標準で1多い数値を返す(行末補正?)。また、index0startの分?も考慮 計2
    let _winview['col'] = _lastcol
    let _winview['curswant'] = _lastcol
    call winrestview(_winview)
endfunction

" python indent
augroup PythonSetting
    autocmd!
    autocmd FileType python,py setlocal ts=8 sts=3 sw=3 et
augroup END

command! ExL call ExecuteLine()
function! ExecuteLine()
    let l:cmd = getline('.')
    exec l:cmd
endfunction
command! ExLs call ExecuteLines()
function! ExecuteLines()
    " TODO: Visual mode
    " NOTE: あと、選択範囲を実行するっていうの、どこかで見た気がする
endfunction

