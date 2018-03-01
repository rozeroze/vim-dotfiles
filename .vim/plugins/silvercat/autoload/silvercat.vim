" vim plugin script
" File: silvercat.vim
" Summary: Make ruler warm and fuzzy
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: MIT
" Version: 2017-10-1

let s:active = 0
let s:timer = v:none
let s:rulerbuf = v:none
let s:mode = v:none
let s:repeat = ['']
let s:index = 0
let s:sleep = 0
let s:list = {
            \ 'n': ["ฅ(๑'Δ'๑)     ", "ฅ(๑'Δ'๑)ﾆｬ   ", "ฅ(๑'Δ'๑)ﾆｬｧ  ", "ฅ(๑'Δ'๑)ﾆｬｧｧ ", "ฅ(๑'Δ'๑)ﾆｬｧｧｧ" ],
            \ 'i': ["φ('ω'=)    ", "φ('ω'=)ｶ   ", "φ('ω'=)ｶｷ  ", "φ('ω'=)ｶｷｶ ", "φ('ω'=)ｶｷｶｷ", "φ('ω'=) ﾆｬ?" ],
            \ 'c': ['(｡･ω･｡)      ', '(｡･ω･｡) :    ', '(｡･ω･｡) :N   ', '(｡･ω･｡) :Ne  ', '(｡･ω･｡) :Nek ', '(｡･ω･｡) :Neko', '(｡･ω･｡) ﾆｬﾝｯ!'],
            \ 'v': ['~(=^･ω･^)ﾉ     ', '~(=^･ω･^)ﾉ ﾆｬｱ ', '^･ω･^)ﾉ ﾆｬｱ    ', 'ω･^)ﾉ ﾆｬｱ     (', ')ﾉ ﾆｬｱ     (ωΦ', 'ﾆｬｱ     (ωΦ^ )', 'ﾆｬｱ ﾐｬ? (ωΦ^ )'],
            \ 'V': ['~(=^･ω･^)ﾉｼ     ', '~(=^･ω･^)ﾉｼ ﾐｬ  ', '~(=^･ω･^)ﾉｼ ﾐｬﾐｬ', '~(=^･ω･^)/ ﾋﾟｰﾝ!', '~(=^･ω･^)ゞ ｶ   ', '~(=^･ω･^)ゞ ｶｼ  ', '~(=^･ω･^)ゞ ｶｼｺ ', '~(=^･ω･^)ゞ ｶｼｺﾏ'],
            \ '': ['~(=^･ω･^)ﾉ       ', '~(=^･ω･^)ｼ       ', '~(=^･ω･^)ﾉ       ', '~(=^･ω･^)ｼ       ', '~(=^･ω･^) ﾀﾞﾚﾓｲﾅｲ', '~(=^･ω･^) ｼｮﾎﾞｰﾝ '],
            \ 's': ['( ^ v _ v^)     ', '( ^ - _ -^)     ', '( ^ ･ _ ･^) .   ', '( ^ ･ _ ･^) ..  ', '( ^ ･ _ ･^) ...?', '( ^ΦДΦ^) ｼｬｰ!', '( ^ ･ _ ･^)     ', '( ^ - _ -^)     '],
            \ 'S': ['( ^ΦωΦ^)     ', '( ^ΦωΦ^) ﾝ   ', '( ^ΦωΦ^) ﾝﾐｬ ', '( ^ΦωΦ^) ﾝﾐｬ?', '( ^ΦДΦ^) ｼｬｰ!'],
            \ '': ['( ^ΦДΦ^)       ', '( ^ΦДΦ^) ｼｬｰ!  ', '( ^ΦДΦ^) .     ', '( ^ΦДΦ^) ..    ', '( ^ΦДΦ^) ...?  ', '( ^;_;^) ﾀﾞﾚﾓｲﾅｶｯﾀ'],
            \ 'r': ["(^..^ )", "(^･･^ )", "( ^..^)", "( ^･･^)"],
            \ 'R': ['(^-ω-^))', '^-ω-^)^)', '-ω-^)*^)', 'ω-^) *^)', ' -^)ω*^)', '-^)*ω*^)', '^)^*ω*^)', ')(^*ω*^)',
            \       '((^*ω*^)', '(^(^*ω*^', '(^-(^*ω*', '(^- (^*ω', '(^-ω(^* ', '(^-ω-(^*', '(^-ω-^(^', '(^-ω-^)('],
            \ '!': ["(  'ω')        ", "(  'ω')ﾁｮｯ     ", "(  'ω')ﾁｮｯﾄ    ", "(  'ω')ﾁｮｯﾄﾏ   ", "(  'ω')ﾁｮｯﾄﾏﾂ  ", "(  `ω')ﾁｮｯﾄﾏﾂﾆｬ" ],
            \ 'z': ['ฅ( ^･_･^)       ', 'ฅ( ^-_-^)       ', 'ฅ( ^-_-^) z     ', 'ฅ( ^-_-^) zz    ', 'ฅ( ^-_-^) zzZ   ', 'ฅ( ^-_-^) zzZZ  ',
            \       'ฅ( ^-_-^).      ', 'ฅ( ^-_-^).o     ', 'ฅ( ^-_-^).o〇   ', 'ฅ( ^-_-^).o〇(  ', 'ฅ( ^-_-^).o〇(🐟', 'ฅ( ^-_-^).o〇(🐡', 'ฅ( ^-_-^).o〇(🐠', 'ฅ( ^-_-^).o〇(🎣', 'ฅ( ^･_･^) ﾊｯ!   ']
            \}

function! silvercat#silvercat()
    if s:active
        let &l:rulerformat = s:rulerbuf
        call timer_stop(s:timer)
        delcommand Neko
    else
        let s:rulerbuf = &rulerformat
        let s:timer = timer_start(500, function('s:rulerfunc'), { 'repeat': -1 })
        command! Neko call s:neko()
    endif
    let s:active = !s:active
endfunction

function! s:rulerfunc(timer) abort
    let _mode = mode()
    if _mode == 'c'
        "
    endif
    if _mode != s:mode
        let s:repeat = s:list[_mode]
        let s:index = 0
        let s:mode = _mode
        let s:sleep = 0
    else
        let s:sleep += 1
        if s:sleep > 40 && s:mode == 'n' && s:repeat != s:list['z']
            let s:repeat = s:list['z']
            let s:index = 0
        endif
    endif
    let &l:rulerformat = s:repeat[s:index]
    let s:index += 1
    if s:index >= len(s:repeat)
        let s:index = 0
    endif
endfunction

function! s:neko()
    if s:active
        put =s:list['c'][-1]
    endif
endfunction

