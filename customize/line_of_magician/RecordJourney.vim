" record of your journey
" TODO: move to new file named RecordJourney
command! RecordJourney :call s:RecordOfYourJourney()
function! s:RecordOfYourJourney()
    let s:message = 'ぼうけんのしょをきろくしますか？'
    let s:status = &statusline
    let &statusline = ''
    for m in ['ぼ', 'う', 'け', 'ん', 'の', 'し', 'ょ', 'を'
                \, 'き', 'ろ', 'く', 'し', 'ま', 'す', 'か', '？']
        let &statusline .= m
        redraw
        sleep 100ms
    endfor
    sleep 200ms
    let &statusline = s:message . ' (y/n)'
    redraw
    let yn = nr2char(getchar())
    if yn == 'y'
        silent execute("w")
        "echo 'save'
        let &statusline = ''
        for m in ['ぼ', 'う', 'け', 'ん', 'の', 'し', 'ょ', 'を'
                    \, 'き', 'ろ', 'く', 'し', 'ま', 'し', 'た']
            let &statusline .= m
            redraw
            sleep 100ms
        endfor
        sleep 200ms
        let while_return = &statusline
        while 1
            let loop = getchar(0)
            if loop != 0
                break
            endif
            let &statusline = &statusline == while_return ? &statusline . ' ⏎' : while_return
            redraw
            sleep 600ms
        endwhile
    elseif yn == 'n'
        echo 'non save'
    else
        echo 'error'
    endif
    let &statusline = s:status
    redraw
endfunction


