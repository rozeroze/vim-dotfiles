""" you missed. you confused. and you lost eternity.


if exists('g:loaded_confusion')
   finish
endif
let g:loaded_confusion = 1

" TODO: {{{
" confusion時はvim-timer機能を使って、colorschemeを点滅させると面白そう
" let _timer = timer_start(6000, 'confusion_flash', { 'repeat' : -1 })
" }}}

" command
command! -nargs=0 Confusion :call <SID>confusion()

" function
function! s:confusion()
   " MEMO: only move now
   nnoremap <silent><script> <up>    :call <SID>move()<CR>
   nnoremap <silent><script> <down>  :call <SID>move()<CR>
   nnoremap <silent><script> <right> :call <SID>move()<CR>
   nnoremap <silent><script> <left>  :call <SID>move()<CR>
   " NOTE: other keys what is move-action it
   " nnoremap <silent><script> h :call <SID>move()<CR>
   " nnoremap <silent><script> j :call <SID>move()<CR>
   " nnoremap <silent><script> k :call <SID>move()<CR>
   " nnoremap <silent><script> l :call <SID>move()<CR>
   " nnoremap <silent><script> w :call <SID>move()<CR>
   " nnoremap <silent><script> e :call <SID>move()<CR>
   " nnoremap <silent><script> b :call <SID>move()<CR>
   " nnoremap <silent><script> W :call <SID>move()<CR>
   " nnoremap <silent><script> E :call <SID>move()<CR>
   " nnoremap <silent><script> B :call <SID>move()<CR>
endfunction

function! s:move()
   " MEMO: move <up><down><right><left>
   let direction = <SID>random(4) " got 0~3
   if direction == 0
      normal! k
   elseif direction == 1
      normal! j
   elseif direction == 2
      normal! h
   elseif direction == 3
      normal! l
   endif
endfunction

function! s:random(num)
   " it depends on OS
   return reltimestr(reltime())[-2:] % a:num
endfunction


" vim: set ts=3 sts=3 sw=3 et :
