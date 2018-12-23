""" File: ftplugin/doteditor_palette.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-21
""" Description: おえかき


if exists('b:did_ftplugin')
   finish
endif
let b:did_ftplugin = 1


""" setlocal
setlocal nobackup noswapfile noundofile
setlocal bufhidden=delete buftype=nofile
setlocal nonumber norelativenumber
setlocal nolist nospell nowrap
setlocal nocursorline nocursorcolumn
setlocal guioptions=

""" mapping
" MEMO: おそらく click -> ↓のマップ処理 -> Vim内部でのカレントバッファの変更
"       の順にイベントが進んでいるのではないか?
nnoremap <nowait><buffer><silent> <LeftMouse> <LeftMouse>:call doteditor#change(getline('.')[0])<cr>
nnoremap <nowait><buffer><silent> <LeftDrag>  <LeftMouse>:call doteditor#change(getline('.')[0])<cr>
"nnoremap <nowait><buffer><silent> <LeftMouse> <LeftMouse>:call doteditor#change(getbufline(bufnr('[palette]'), '.')[0][0])<cr>
"nnoremap <nowait><buffer><silent> <LeftDrag>  <LeftMouse>:call doteditor#change(getbufline(bufnr('[palette]'), '.')[0][0])<cr>
"nnoremap <nowait><buffer><silent> <LeftMouse> <LeftMouse>:echo getbufinfo('[palette]')<cr>
"nnoremap <nowait><buffer><silent> <LeftDrag>  <LeftMouse>:echo getbufinfo('[palette]')<cr>


" vim: set ts=3 sts=3 sw=3 et :
