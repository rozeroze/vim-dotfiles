""" Theme: life
""" Sumary: 生命
""" Version: 2018-07-17

if !has('timers')
   finish
endif
if exists('g:loaded_life')
   finish
endif
let g:loaded_life = 1

" TODO: バグ 裁定方式か、基準か、なにかが違う
"       グライダーを手動で作成時に発見

" let s:sample {{{
let s:sample = {}
let s:sample['block'] = [ '    ' ,
                        \ ' ** ' ,
                        \ ' ** ' ,
                        \ '    ' ]
let s:sample['honeycomb'] = [ '      ' ,
                            \ '  **  ' ,
                            \ ' *  * ' ,
                            \ '  **  ' ,
                            \ '      ' ]
let s:sample['boat'] = [ '     ' ,
                       \ ' **  ' ,
                       \ ' * * ' ,
                       \ '  *  ' ,
                       \ '     ' ]
let s:sample['ship'] = [ '     ' ,
                       \ '  ** ' ,
                       \ ' * * ' ,
                       \ ' **  ' ,
                       \ '     ' ]
let s:sample['pond'] = [ '      ' ,
                       \ '  **  ' ,
                       \ ' *  * ' ,
                       \ ' *  * ' ,
                       \ '  **  ' ,
                       \ '      ' ]
let s:sample['glider'] = [ '      ' ,
                         \ ' ***  ' ,
                         \ ' *    ' ,
                         \ '  *   ' ,
                         \ '      ' ,
                         \ '      ' ]
" }}}

let s:life = {}
let s:life['live'] = '*'
let s:life['wall'] = '#'
let s:life['row'] = 0
let s:life['column'] = 0

""" tabopenして、Life用フィールドを確保
function! s:open()
   tabnew -- LIFE --
   setlocal nobackup noswapfile noundofile
   setlocal buftype=nofile
   setlocal nonumber norelativenumber
   setlocal nolist nospell nowrap
   setlocal nocursorline nocursorcolumn
   setlocal guioptions=
   set scrolloff=0 sidescrolloff=0
   set linespace=0
   if exists('&charspace')
      " kaoriya
      set charspace=0
   endif
endfunction

""" fieldのx軸とy軸の情報をセット
function! s:setup()
   " offset 2 is command-line & system-message-line
   let s:life['lines'] = &lines - 2
   let s:life['columns'] = &columns
   " offset showtabline & laststatus(statusline)
   if &laststatus == 2
      let s:life['lines'] -= 1
   endif
   if &showtabline != 0
      let s:life['lines'] -= 1
   endif
endfunction

""" 空のfieldを表示、壁を設定
function! s:fieldmake()
   silent normal! ggdG
   call append(line('$'), repeat(s:life['wall'], s:life['columns']))
   call append(line('$'), repeat([s:life['wall'] . repeat(' ', s:life['columns']-2) . s:life['wall']], s:life['lines']-2))
   call append(line('$'), repeat(s:life['wall'], s:life['columns']))
   silent normal! ggdd
endfunction

""" 先住民族をセット
function! s:natives()
   let lifes = abs(reltime()[1]) % (s:life['lines'] * s:life['columns'])
   while lifes
      let pop_line   = abs(reltime()[1] * lifes) % s:life['lines']
      let pop_column = abs(reltime()[1] * lifes) % s:life['columns']
      let line = getline(pop_line)
      if line[pop_column] == ' '
         let line = line[:pop_column-1] . s:life['live'] . line[pop_column+1:]
         call setline(pop_line, line)
      endif
      let lifes -= 1
   endwhile
endfunction

""" 砂時計の砂が落ちる next-turn
function! s:sanddrop(timer)
   let next = getline(1, line('$'))
   let _row = 0
   for _line in next
      let _column = 0
      for _char in split(_line, '\zs')
         if _char != s:life['wall']
            let result = <sid>ruling(_char, _row, _column)
            if result != _char
               " MEMO: 変化があれば next を更新
               let next[_row] = next[_row][:_column-1] . result . next[_row][_column+1:]
            endif
         endif
         let _column += 1
      endfor
      let _row += 1
   endfor
   call <sid>update(next)
endfunction

""" 裁定を行なう
function! s:ruling(char, row, column)
   let nearlife = <sid>detect(a:row, a:column)
   if a:char == s:life['live']
      " MEMO: detect()は自身を含めた数なので、自身の分を引く
      let nearlife -= 1
      " point (x, y)自身は生きている
      "   nearlife is 0 or 1 -> death(過疎により死滅)
      "   nearlife is 2 or 3 -> alive(生存)
      "   nearlife is over 4 -> death(過密により死滅)
      if nearlife == 2 || nearlife == 3
         return s:life['live']
      else
         return ' '
      endif
   else
      " point (x, y)は更地（死んでいる）
      "   nearlife is over 3 -> born(誕生)
      "   nearlife is other  -> none(生命は生まれない)
      if nearlife >= 3
         return s:life['live']
      else
         return ' '
      endif
   endif
endfunction

""" 生者（の数）を探す
function! s:detect(row, column)
   " MEMO: point (x, y)を中心に9マスの生者の数を返す
   let list = []
   " XXX: いつのまにかずれている
   "let over = getline(a:row - 1)[a:column-1 : a:column+1]
   "let middle = getline(a:row)[a:column-1 : a:column+1]
   "let under = getline(a:row + 1)[a:column-1 : a:column+1]
   let over = getline(a:row)[a:column-1 : a:column+1]
   let middle = getline(a:row + 1)[a:column-1 : a:column+1]
   let under = getline(a:row + 2)[a:column-1 : a:column+1]
   call extend(list, split(over, '\zs'))
   call extend(list, split(middle, '\zs'))
   call extend(list, split(under, '\zs'))
   return count(list, s:life['live'])
endfunction

""" fieldを上書きする
function! s:update(lines)
   silent normal! ggdG
   call append(0, a:lines)
   silent normal! Gddgg
   redraw
endfunction

""" 再び...
function! s:relive()
   call timer_pause(b:timer, 1)
   call <sid>setup()
   call <sid>fieldmake()
   call <sid>natives()
   call timer_pause(b:timer, 0)
endfunction

""" 時の砂時計
function! s:pause()
   let _info = timer_info(b:timer)
   call filter(_info, 'v:val["id"] == ' . b:timer)
   if _info == []
      " error:
   else
      call timer_pause(b:timer, !_info[0]['paused'])
   endif
endfunction

""" 神の手
function! s:hand()
   if !has('gui_running')
      return
   endif
   if match(&mouse, 'n') == -1
      return
   endif
   noremap <nowait><buffer><silent> <LeftMouse> <LeftMouse>:call <sid>wand()<cr>
   noremap <nowait><buffer><silent> <LeftDrag>  <LeftMouse>:call <sid>wand()<cr>
endfunction

""" 生命の杖
function! s:wand()
   let c = getline('.')[col('.') - 1]
   if c == ' '
      silent normal! r*
      redraw
   endif
endfunction

""" 神の雷
function! s:thunder()
   let c = getline('.')[col('.') - 1]
   if c == '*'
      silent normal! r 
      redraw
   endif
endfunction

""" Life Start
function! s:Life()
   call <sid>open()
   call <sid>setup()
   call <sid>fieldmake()
   call <sid>natives()
   call <sid>hand()
   let b:timer = timer_start(500, function('s:sanddrop'), { 'repeat': -1 })
   " syntax
   syntax match LifeGameWall '#'
   syntax match LifeGameLiver '*'
   highlight default link LifeGameWall Comment
   highlight default link LifeGameLiver String
   " mapping
   nnoremap <nowait><buffer> q :bdelete<cr>
   nnoremap <nowait><buffer><silent> r :call <sid>relive()<cr>
   nnoremap <nowait><buffer><silent> p :call <sid>pause()<cr>
   nnoremap <nowait><buffer><silent> w :call <sid>wand()<cr>
   nnoremap <nowait><buffer><silent> t :call <sid>thunder()<cr>
   " autocmd
   augroup LifeGame
      autocmd!
      autocmd BufLeave <buffer> :call timer_stop(b:timer)
      autocmd TabLeave <buffer> :bdelete
      autocmd WinLeave <buffer> :bdelete
      autocmd QuitPre <buffer> :bdelete
      autocmd VimResized <buffer> :call <sid>relive()
   augroup END
endfunction

command! -nargs=0 Life :call <sid>Life()

" vim: set ts=3 sts=3 sw=3 et :
