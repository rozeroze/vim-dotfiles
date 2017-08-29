" yule riot zit


let g:yuleriotzit#statusline#battletime_interval = 2000

let g:yuleriotzit#statusline#battle_threshold_default = 150

function! g:yuleriotzit#yule_battle#battle(...) abort
    if a:0 > 0
        let s:text = a:1
        let s:miss = 0
        let s:timer = timer_start(g:yuleriotzit#statusline#battletime_interval,
                    \ 'g:yuleriotzit#yule_battle#battletime', {'repeat': -1})
        for i in range(0, len(s:text) - 1)
            let &l:statusline = s:text[i:]
            redraw
            let s:input = nr2char(getchar())
            if s:input == ''
                break
            elseif s:input == s:text[i]
                " ok
            else
                let s:miss += 1
            endif
        endfor

        set statusline&
        call timer_stop(s:timer)

        " TODO: 型チェック
        let s:threshold = g:yuleriotzit#statusline#battle_threshold_default
        if a:0 > 1
            let s:threshold = a:2
        endif
        if s:miss > s:threshold
            " fail
            return 0
        endif
        return 1
    endif
endfunction
function! g:yuleriotzit#yule_battle#battletime(...) abort
    let s:miss += 1
endfunction


command! YuleBattleTest :call s:yuleBattleTest()
function! s:yuleBattleTest()
    echo ''
    if g:yuleriotzit#yule_battle#battle('test')
        echo 'success'
    else
        echo 'fail'
    endif
endfunction
