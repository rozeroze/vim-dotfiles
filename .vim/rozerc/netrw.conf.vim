""" netrw config


" use open browser
let g:netrw_nogx = 1 " disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" buftype
" TODO: buftypeがおかしいときがある

" get path what file under cursor
" TODO: nnoremapでできると思う
"       問題は読込タイミング


" vim: set ts=3 sts=3 sw=3 et :
