""" File: moveme.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2019-03-10

""" Description: Move Vim-application-window

if exists('g:loaded_moveme')
   finish
endif
let g:loaded_moveme = 1

""" Variable
" let s:default = {} {{{
let s:default = {}
let s:default.points = 10
let s:default.lines = 1
let s:default.columns = 2
let s:default.ascii_enable = v:false
let s:default.ascii_file = ''
lockvar! s:default
" }}}

""" Move & Resize
" function! s:Move_[hjkl]() {{{
function! s:Move_h()
   let [x, y] = [getwinposx(), getwinposy()]
   let x -= g:moveme.points
   call execute(join(['winpos', x, y]))
   normal! gg
endfunction
function! s:Move_j()
   let [x, y] = [getwinposx(), getwinposy()]
   let y += g:moveme.points
   call execute(join(['winpos', x, y]))
   normal! gg
endfunction
function! s:Move_k()
   let [x, y] = [getwinposx(), getwinposy()]
   let y -= g:moveme.points
   call execute(join(['winpos', x, y]))
   normal! gg
endfunction
function! s:Move_l()
   let [x, y] = [getwinposx(), getwinposy()]
   let x += g:moveme.points
   call execute(join(['winpos', x, y]))
   normal! gg
endfunction
" }}}
" function! s:Size_[HJKL]() {{{
function! s:Size_H()
   let &columns -= g:moveme.columns
endfunction
function! s:Size_J()
   let &lines += g:moveme.lines
endfunction
function! s:Size_K()
   let &lines -= g:moveme.lines
endfunction
function! s:Size_L()
   let &columns += g:moveme.columns
endfunction
" }}}
" function! s:Size_(Big|Small)() {{{
function! s:Size_Big()
   let &lines += g:moveme.lines
   let &columns += g:moveme.columns
endfunction
function! s:Size_Small()
   let &lines -= g:moveme.lines
   let &columns -= g:moveme.columns
endfunction
" }}}

""" MoveMe Fin
" function! s:Fin() {{{
function! s:Fin()
   " TODO: ascii_movieを実装したときのため
   if exists('b:ascii_anim')
      call timer_stop(b:ascii_anim)
   endif
endfunction
" }}}

""" MoveMe Start
" function! s:Reset() {{{
function! s:Reset()
   let g:moveme = deepcopy(s:default)
endfunction
" }}}
" function! s:Check() {{{
function! s:Check()
   " 設定値が存在するかと、各設定値のデータ型が正しいか
   if !has_key(g:moveme, 'points') || type(g:moveme.points) != v:t_number
      return v:false
   endif
   if !has_key(g:moveme, 'lines') || type(g:moveme.lines) != v:t_number
      return v:false
   endif
   if !has_key(g:moveme, 'columns') || type(g:moveme.columns) != v:t_number
      return v:false
   endif
   if !has_key(g:moveme, 'ascii_enable') || type(g:moveme.ascii_enable) != v:t_bool
      return v:false
   endif
   if !has_key(g:moveme, 'ascii_file')
      return v:false
   endif
   " AsciiFile
   if g:moveme.ascii_enable
      if !filereadable(g:moveme.ascii_file)
         return v:false
      endif
   endif
   return v:true
endfunction
" }}}
" function! s:Open() {{{
function! s:Open()
   tabnew [MoveMe]
   setlocal nobackup noswapfile noundofile
   setlocal buftype=nofile
   setlocal nonumber norelativenumber
   setlocal nolist nospell nowrap
   setlocal nocursorline nocursorcolumn
endfunction
" }}}
" function! s:Map() {{{
function! s:Map()
   nnoremap <buffer><silent><nowait> h :call <sid>Move_h()<cr>
   nnoremap <buffer><silent><nowait> j :call <sid>Move_j()<cr>
   nnoremap <buffer><silent><nowait> k :call <sid>Move_k()<cr>
   nnoremap <buffer><silent><nowait> l :call <sid>Move_l()<cr>
   nnoremap <buffer><silent><nowait> H :call <sid>Size_H()<cr>
   nnoremap <buffer><silent><nowait> J :call <sid>Size_J()<cr>
   nnoremap <buffer><silent><nowait> K :call <sid>Size_K()<cr>
   nnoremap <buffer><silent><nowait> L :call <sid>Size_L()<cr>
   nnoremap <buffer><silent><nowait> < :call <sid>Size_Small()<cr>
   nnoremap <buffer><silent><nowait> > :call <sid>Size_Big()<cr>
   nnoremap <buffer><silent><nowait> q :bdelete<cr>
   nnoremap <buffer><silent><nowait> <esc> :bdelete<cr>
   nnoremap <buffer><silent><nowait> <cr> :bdelete<cr>
   nnoremap <buffer><silent><nowait> <return> :bdelete<cr>
endfunction
" }}}
" function! s:Ascii() {{{
function! s:Ascii()
   if g:moveme.ascii_enable
      call append(0, readfile(g:moveme.ascii_file))
      redraw
   endif
endfunction
" }}}
" function! s:MoveMe() {{{
function! s:MoveMe()
   if !exists('g:moveme') || type(g:moveme) != v:t_dict
      call <sid>Reset()
   endif
   if <sid>Check() == v:false
      echo 'error: processing cannot start because the g:moveme is wrong! -moveme.vim'
      return
   endif
   call <sid>Open()
   call <sid>Map()
   call <sid>Ascii()
   call append(line('$'), repeat([''], &lines + &columns))
   augroup MoveMe
      autocmd!
      autocmd BufLeave <buffer> :call <sid>Fin()
      autocmd TabLeave <buffer> :bdelete
      autocmd WinLeave <buffer> :bdelete
      autocmd QuitPre <buffer> :bdelete
   augroup END
endfunction
" }}}
nmap <nowait><unique> <Plug>MoveMe :<c-u>call <sid>MoveMe()<cr>
command! MoveMe :call <sid>MoveMe()

" vim: set ts=3 sts=3 sw=3 et :
