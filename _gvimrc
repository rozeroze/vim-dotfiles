colorscheme frozendaiquiri

" あんず
set guifont=あんずもじ等幅:h12:cSHIFTJIS:qDRAFT

" GUI　オプション
set guioptions=e

" Vim ウィンドウサイズ
set lines=24
set columns=80

" ruler statuslineの右にあるあれ << 12,34-56 78% >>
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" syntax test
" FIXME: シンタックス '!!!' と '???' が認識されない
"autocmd BufRead *.vim so $VIM\customize\suiSyntax.vim
"autocmd BufRead *.* syn keyword Todo contained TODO FIXME OPTIMIZE HACK REVIEW XXX NOTE !!! ???
autocmd BufRead *.vim syn keyword vimTodo contained TODO FIXME OPTIMIZE HACK REVIEW XXX NOTE !!! ??? SORROW IMPLEMENT_LATER
autocmd BufRead *.cs syn keyword csTodo contained TODO FIXME OPTIMIZE HACK REVIEW XXX NOTE !!! ??? SORROW IMPLEMENT_LATER
autocmd BufRead *.js syn keyword javaScriptCommentTodo contained TODO FIXME OPTIMIZE HACK REVIEW XXX NOTE !!! ??? SORROW IMPLEMENT_LATER


" return of VISUALBELL! 帰ってきた男たち
" NOTE: おそらくだが、vimrcの後に読まれる何かでリセットされている
"       仕様で、GUIがスタートするときにリセットされるようだ
set t_vb=

" intro gvimrc でないと効かないらしい
set shortmess+=I

" mouse return
set mouse=n


