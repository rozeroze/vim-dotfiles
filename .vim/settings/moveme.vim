""" Theme: win move [mode]
""" Summary: Vimのアプリケーションウィンドウを動かす
""" Version: 2018-06-20

" to be package
finish

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
" TODO: size変更の時に、縦と横を同時に大きくする・小さくするmapを実装
"       (b)igと(s)mallにしようとも思うが、キーが離れているので打ちがたい
"       '<'と'>'にしようと検討中
" CHANGELOG: 縦と横を一括でサイズ変更できるように変更、Smallは<、Bigは>にて実行
" PLAY: bufferlocalなtimer変数を宣言すれば、moveme.asciiにアニメーションを実装できる?
"       let b:anim = timer_start()
" CHANGELOG: AsciiArtを表示するか否かを設定値として持つように変更
" TODO: AsciiArtの設定値だけでなく、tabnewするか否かも設定したい
" MEMO: tabnew教はあまねく信者を募集している　必ずtabnewすることを教義としている
" TODO: :quitなどでMoveMeFin()を介さず終了することを制御する
"       あるいは、autocmdでなんとかする showtablineが消える問題
" }}}


""" Config
" SetAscii(...) {{{
function! s:SetAscii(...)
   let s:moveme = {}
   if a:0 == 1
      if type(a:1) == v:t_dict
         let s:moveme = a:1
      else
         "echo 'error occurred: argument-type was wrong. -moveme.vim'
         call <SID>AsciiDisabled()
      endif
   else
      "echo 'error occurred: number-of-argument wrong. -moveme.vim'
      call <SID>AsciiDisabled()
   endif
endfunction
" }}}
" CheckAsciiFile() {{{
function! s:CheckAsciiFile()
   if s:moveme.ascii_file != ''
      if filereadable(s:moveme.ascii_file)
         " pass
      else
         call <SID>AsciiDisabled()
      endif
   else
      call <SID>AsciiDisabled()
   endif
endfunction
" }}}
" AsciiDisabled() {{{
function! s:AsciiDisabled()
   let s:moveme.ascii_enable = v:false
   let s:moveme.ascii_file = ''
endfunction
" }}}

""" MoveMe
command! MoveMe :call <SID>MoveMe()
" MoveMe() {{{
function! s:MoveMe() abort
   echo ''
   if s:moveme.ascii_enable
      call <SID>CheckAsciiFile()
   endif
   call <SID>MoveMeOpen()
   call <SID>MoveMeSets()
   call <SID>MoveMeMaps()
   call <SID>MoveMeAscii()
   " measures of repeat
   call append(line('$'), split(repeat(' ', &lines + &columns), '\zs'))
   norm! gg
endfunction
" }}}
" MoveMeOpen() {{{
function! s:MoveMeOpen()
   " MEMO: asciiが無効でもtabnewする
   " TODO: tabnewするか否かの設定値を作る
   " MEMO: tabnewは絶対！教祖様の言うことに間違いはない
   "if s:moveme.ascii_enable
      tabnew
      silent file `='[MOVE MODE]'`
   "endif
   redraw
endfunction
" }}}
" MoveMeSets() {{{
function! s:MoveMeSets()
   let s:showtabline = &showtabline
   set showtabline=0
   setlocal nobackup noswapfile noundofile
   setlocal buftype=nofile
   setlocal nonumber norelativenumber
   setlocal nolist nospell nowrap
   setlocal nocursorline nocursorcolumn
   setlocal guioptions=
endfunction
" }}}
" MoveMeMaps() {{{
function! s:MoveMeMaps()
   " move, resize, and quit
   nnoremap <buffer><silent><nowait> h :call <SID>Move_h()<CR>
   nnoremap <buffer><silent><nowait> j :call <SID>Move_j()<CR>
   nnoremap <buffer><silent><nowait> k :call <SID>Move_k()<CR>
   nnoremap <buffer><silent><nowait> l :call <SID>Move_l()<CR>
   nnoremap <buffer><silent><nowait> H :call <SID>Size_H()<CR>
   nnoremap <buffer><silent><nowait> J :call <SID>Size_J()<CR>
   nnoremap <buffer><silent><nowait> K :call <SID>Size_K()<CR>
   nnoremap <buffer><silent><nowait> L :call <SID>Size_L()<CR>
   nnoremap <buffer><silent><nowait> < :call <SID>Size_Small()<CR>
   nnoremap <buffer><silent><nowait> > :call <SID>Size_Big()<CR>
   nnoremap <buffer><silent><nowait> q :call <SID>MoveMeFin()<CR>
   nnoremap <buffer><silent><nowait> <ESC> :call <SID>MoveMeFin()<CR>
   nnoremap <buffer><silent><nowait> <Return> :call <SID>MoveMeFin()<CR>
   " other key
   let other = split('qwertyuiopasdfgzxcvbnm', '\zs')
   for c in other
      execute 'nnoremap <buffer><silent><nowait> ' . c . ' <Nop>'
   endfor
endfunction
" }}}
" MoveMeAscii() {{{
function! s:MoveMeAscii()
   if s:moveme.ascii_enable
      let path = expand(s:moveme.ascii_file)
      if glob(path) != ''
         call append(0, readfile(path))
         redraw
      endif
   endif
   " MEMO: 我らが教義を！
   "call append(0, ['tabnew教をご存知ですか？',
   "              \ 'tabnew神はこの世のすべてをご存知です。',
   "              \ 'あなたに安らぎのあらんことを……'])
endfunction
" }}}

""" MoveMe Finish
" MoveMeFin() {{{
function! s:MoveMeFin()
   let &showtabline = s:showtabline
   bdelete %
endfunction
" }}}

""" MoveMe Move and Resize
" Move_{hjkl}() {{{
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
" Size_{HJKL}() {{{
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
" Size_{Big|Small}() {{{
function! s:Size_Big()
   let &lines += 1
   let &columns += 2
endfunction
function! s:Size_Small()
   let &lines -= 1
   let &columns -= 2
endfunction
" }}}

""" Init MoveMe Settings
if exists('g:rzrz.moveme')
   call <SID>SetAscii(g:rzrz.moveme)
   call <SID>CheckAsciiFile()
else
   call <SID>SetAscii()
endif


" vim: set ts=3 sts=3 sw=3 et :
