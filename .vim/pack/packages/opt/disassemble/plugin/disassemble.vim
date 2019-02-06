" Vim plugin script
" File: disassemble.vim
" Summary: ソースコードを読めるようにする
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2018-12-20


" preview: 編集中のバッファとは別にreadonlyな表示専用バッファを開く
"    これがオフだと編集中のバッファを直接変更する
" preview-window: previewがオンのとき、表示専用バッファをどう開くか
"    [ vertical | horizon | newtab ] のいずれか (default -> vertical)
let s:option = {
             \   'preview': v:true,
             \   'preview-window': 'vertical'
             \ }

function! s:disassemble()
endfunction




" vim: set ts=3 sts=3 sw=3 et :
