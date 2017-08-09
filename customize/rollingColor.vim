" test

" timer was supported by Vim version over 8.0
if v:version < 800
    finish
endif


" timer test
"let s:iter = 0
"function! TestTimer(timer)
"    echo s:iter
"    let s:iter += 1
"endfunction
"let timer = timer_start(500, 'TestTimer', { 'repeat' : 5 })



" timer test2
"let s:color_orig = g:colors_name
"let s:status = &statusline
"let s:colors = split(expand('$VIM/vim80/colors/*.vim'), "\n")
"for c in s:colors
"    execute('colorscheme ' . fnamemodify(c, ":t:r"))
"    let &statusline = fnamemodify(c, ":t:r")
"    redraw
"    sleep 1000ms
"endfor
"execute('colorscheme ' . s:color_orig)
"let &statusline = s:status
"redraw



let s:num = 0
let s:colors = split(expand('$VIM/vim80/colors/*.vim'), "\n")
let s:maxnum = len(s:colors)
func! RollingColor(timer) abort
    execute('colorscheme ' . fnamemodify(s:colors[s:num], ":t:r"))
    let s:num += 1
    let &statusline = expand('%') . ' [' . g:colors_name . ']'
    let s:num = s:maxnum <= s:num ? 0 : s:num
endfunc
func! StartRolling(...) abort
    let s:interval = a:0 >=1 ? a:1 : 1000
    let s:timer = timer_start(s:interval, 'RollingColor', { 'repeat' : -1 })
endfunc
" TODO: can set args <interval>
"command! -nargs=? RollingColor let s:timer_start(<interval>...
command! -nargs=? RollingColor :call StartRolling(<f-args>)
command! StopRolling :call timer_stop(s:timer)
command! StopAllTimers :call timer_stopall()

" name correct
"let &statusline = expand('%')


"let s:isToggle = 1
"func! ToggleColor(timer) abort
"    if s:isToggle
"        colorscheme evening
"    else
"        colorscheme frozendaiquiri
"    endif
"    let s:isToggle = !s:isToggle
"endfunc
"command! ToggleColor let s:timer = timer_start(500, 'ToggleColor', { 'repeat' : 100 })
"command! StopColor :call timer_stop(s:timer)



