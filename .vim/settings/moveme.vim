""" win move [mode]


if exists('g:loaded_moveme')
   finish
endif
let g:loaded_moveme = 1


""" comment {{{
" TODO: 開いているバッファをhiddenにし、一時的なバッファを開く
"       一時バッファにローカルなmappingを設定し、
"       移動とサイズ変更を設定する nnoremap <buffer> ...
"       escかqかreturn等が押されたら一時バッファをbdeleteし
"       隠したバッファを開きなおす→Clear
" MEMO: mappingにする理由
"       {number}h などの入力で{number}分左に移動
"       回数を前置できるだろうから→できなかった
" MEMO: 一時バッファを開く理由
"       mappingを設定するにあたり、既存のmappingに影響がでないように
" NOTE: 一時buffer削除時に、別のbufferまで削除してします不具合
"       条件 画面分割時,複数tab表示時に起動した場合
" CHANGELOG: number前置対策 ex: 13h 例として13回分左に移動したい場合、
"            :.,.+13call Move_h() というcommandになる
"            これは現在の行から下に数えて13行、計14行の各行に対し
"            Move_h()を呼ぶという意味になるようだ
"            対策措置として空行を並べたので、一定値以内の数値前置なら可能になった
" TODO: hide-enew形式をやめ、tabnewにする
"       また、Tab関連の削除を追加する autocmd TabLeave moveme :bdelete
"       moveme実行中はtabが表示されないような設定がないか調査→showtabline
" CHANGELOG: tabnew方式に変更 (autocmd TabLeaveは未実装)
" }}}

command! MoveMe :call <SID>MoveMe()
function! s:MoveMe() abort
   echo ''
   "hide enew
   tabnew
   silent file `='[MOVE MODE]'`
   redraw
   " set
   let s:showtabline = &showtabline
   set showtabline=0
   setlocal nobackup noswapfile noundofile
   setlocal buftype=nofile
   setlocal nonumber norelativenumber
   setlocal nolist nospell nowrap
   setlocal nocursorline nocursorcolumn
   setlocal guioptions=
   " move, resize, and quit
   nnoremap <buffer><silent><nowait> h :call <SID>Move_h()<CR>
   nnoremap <buffer><silent><nowait> j :call <SID>Move_j()<CR>
   nnoremap <buffer><silent><nowait> k :call <SID>Move_k()<CR>
   nnoremap <buffer><silent><nowait> l :call <SID>Move_l()<CR>
   nnoremap <buffer><silent><nowait> H :call <SID>Size_H()<CR>
   nnoremap <buffer><silent><nowait> J :call <SID>Size_J()<CR>
   nnoremap <buffer><silent><nowait> K :call <SID>Size_K()<CR>
   nnoremap <buffer><silent><nowait> L :call <SID>Size_L()<CR>
   "nnoremap <buffer><silent><nowait> q :bdelete %<CR>
   "nnoremap <buffer><silent><nowait> <ESC> :bdelete %<CR>
   "nnoremap <buffer><silent><nowait> <Return> :bdelete %<CR>
   nnoremap <buffer><silent><nowait> q :call <SID>MoveMeFin()<CR>
   nnoremap <buffer><silent><nowait> <ESC> :call <SID>MoveMeFin()<CR>
   nnoremap <buffer><silent><nowait> <Return> :call <SID>MoveMeFin()<CR>
   " other
   let other = split('qwertyuiopasdfgzxcvbnm', '\zs')
   for c in other
      execute 'nnoremap <buffer> <silent> <nowait> ' . c . ' <Nop>'
   endfor
   " ascii
   let path = expand('~/.vim/settings/moveme.ascii.txt')
   if glob(path) != ''
      call append(0, readfile(path))
      redraw
   endif
   " measures of repeat
   call append(line('$'), split(repeat(' ', &lines + &columns), '\zs'))
   norm! gg
endfunction

function! s:MoveMeFin()
   let &showtabline = s:showtabline
   bdelete %
endfunction

""" Move_{hjkl}() {{{
function! s:Move_h()
   let [winposx, winposy] = [getwinposx() - 10, getwinposy()]
   call execute(join(['winpos', winposx, winposy]))
   norm! gg
endfunction
function! s:Move_j()
   let [winposx, winposy] = [getwinposx(), getwinposy() + 10]
   call execute(join(['winpos', winposx, winposy]))
   norm! gg
endfunction
function! s:Move_k()
   let [winposx, winposy] = [getwinposx(), getwinposy() - 10]
   call execute(join(['winpos', winposx, winposy]))
   norm! gg
endfunction
function! s:Move_l()
   let [winposx, winposy] = [getwinposx() + 10, getwinposy()]
   call execute(join(['winpos', winposx, winposy]))
   norm! gg
endfunction
" }}}

""" Size_{HJKL}() {{{
function! s:Size_H()
   let &columns -= 2
endfunction
function! s:Size_J()
   let &lines += 1
endfunction
function! s:Size_K()
   let &lines -= 1
endfunction
function! s:Size_L()
   let &columns += 2
endfunction
" }}}


" vim: set ts=3 sts=3 sw=3 et :
