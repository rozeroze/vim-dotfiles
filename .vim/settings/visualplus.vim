""" Theme: improve visual-mode
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-12-13


if exists('g:loaded_visualplus')
   finish
endif
let g:loaded_visualplus = 1


" zz にて現在行を中心にスクロールするのを、範囲中心のスクロールに変更
xnoremap zz :VScrollMiddle<cr>
command! -range VScrollMiddle :call <sid>V_zz(<line1>, <line2>, <count>)
function! s:V_zz(line1, line2, count)
   let mid = (a:line2 - a:line1 + 1) / 2
   call execute(a:line2 - mid)
   normal! zz
   normal! gv
endfunction


" {visual}zf にて折畳を作成する操作を変更
" 行内に折畳markerを追加→折畳marker用に行を追加
xnoremap zf :VMakeFoldMarker<cr>
command! -range VMakeFoldMarker :call <sid>V_zf(<line1>, <line2>, <count>)
function! s:V_zf(line1, line2, count)
   if &foldmethod == 'manual'
      setlocal foldenable
      normal! gvzf
   elseif &foldmethod == 'marker'
      setlocal foldenable
      let fm = split(&foldmarker, ',')
      call append(a:line2    , printf(&commentstring, fm[1]))
      call append(a:line1 - 1, printf(&commentstring, fm[0]))
      normal! '<km<
      normal! '>jm>
      normal! gv=
   endif
endfunction


" shifting-lines時に範囲選択が解除されるのを阻止
" 範囲選択を再度するscriptだと一瞬blinkしてしまうのを阻止
vnoremap <silent> < :<c-u>call <sid>V_sl('<')<cr>
vnoremap <silent> > :<c-u>call <sid>V_sl('>')<cr>
function! s:V_sl(ward)
   execute 'normal!' 'gv' . v:count1 . a:ward
   normal! gv
endfunction

" visual-mode の object-select を追加
" vi/ にて検索キーワードがある行を除く中間部分を選択する
" va/ にて検索キーワードがある行を含む中間部分を選択する
" e.g. レビューが必要な箇所を // REVIEW で囲っている場合などに役立つ
nnoremap <silent><nowait> vi/ :<c-u>call <sid>V_slash(0, 'i')<cr>
nnoremap <silent><nowait> va/ :<c-u>call <sid>V_slash(0, 'a')<cr>
"nnoremap <silent><nowait> Vi/ :<c-u>call <sid>V_slash(1, 'i')<cr>
"nnoremap <silent><nowait> Va/ :<c-u>call <sid>V_slash(1, 'a')<cr>
function! s:V_slash(line, ia)
   echo printf('line: %s ia: %s', a:line, a:ia)
   let save_curpos = getcurpos()
   let save_search = @/
   let search = input('/')
   if search == ""
      return
   endif
   execute '?' . search
   let before = line('.')
   call setpos('.', save_curpos)
   execute '/' . search
   let after = line('.')
   echo printf('before: %s after: %s', before, after)
endfunction


" vim: set ts=3 sts=3 sw=3 et :
