""" File: ftplugin/doteditor.vim
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
" show help
nnoremap <nowait><buffer><silent> ? :call doteditor#help()<cr>
" draw
nnoremap <nowait><buffer><silent> <LeftMouse> <LeftMouse>:call doteditor#draw()<cr>
nnoremap <nowait><buffer><silent> <LeftDrag>  <LeftMouse>:call doteditor#draw()<cr>
" change color
nnoremap <nowait><buffer><silent> B :call doteditor#change('B')<cr>
nnoremap <nowait><buffer><silent> b :call doteditor#change('b')<cr>
nnoremap <nowait><buffer><silent> r :call doteditor#change('r')<cr>
nnoremap <nowait><buffer><silent> m :call doteditor#change('m')<cr>
nnoremap <nowait><buffer><silent> l :call doteditor#change('l')<cr>
nnoremap <nowait><buffer><silent> c :call doteditor#change('c')<cr>
nnoremap <nowait><buffer><silent> y :call doteditor#change('y')<cr>
nnoremap <nowait><buffer><silent> w :call doteditor#change('w')<cr>
" erase / all clear
nnoremap <nowait><buffer><silent> e :call doteditor#change(' ')<cr>
nnoremap <nowait><buffer><silent> # :call doteditor#clear()<cr>
" capture color
nnoremap <nowait><buffer><silent> $ :call doteditor#capture()<cr>
" scaling enlarge / shrink
nnoremap <nowait><buffer><silent> + :call doteditor#enlarge()<cr>
nnoremap <nowait><buffer><silent> - :call doteditor#shrink()<cr>
" palette
nnoremap <nowait><buffer><silent> p :call doteditor#palette()<cr>
" generate bitmap / gif
"nnoremap <nowait><buffer><silent> . :call doteditor#bitmap()<cr>
"nnoremap <nowait><buffer><silent> * :call doteditor#gif()<cr>
nnoremap <nowait><buffer><silent> * :call doteditor#generate()<cr>


" vim: set ts=3 sts=3 sw=3 et :
