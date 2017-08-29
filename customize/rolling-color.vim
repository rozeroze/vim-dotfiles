
if !has('timers')
    finish
endif

command! -nargs=? RollingColor call StartRolling(<f-args>)
command! StopRolling call StopRolling()
command! StopAllTimers call timer_stopall()

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
func! StopRolling() abort
    if !exists("s:timer")
        return
    endif
    call timer_stop(s:timer)
    set statusline&
endfunc


