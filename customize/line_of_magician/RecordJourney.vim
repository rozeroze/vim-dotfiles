" record of your journey

command! RecordJourney :call s:RecordOfYourJourney()
function! s:RecordOfYourJourney()
    let s:message = 'ぼうけんのしょをきろくしますか？'
    let s:status = &l:statusline
    let &l:statusline = ''
    for m in ['ぼ', 'う', 'け', 'ん', 'の', 'し', 'ょ', 'を'
                \, 'き', 'ろ', 'く', 'し', 'ま', 'す', 'か', '？']
        let &l:statusline .= m
        redraw
        sleep 100ms
    endfor
    sleep 200ms
    let &l:statusline = s:message . ' (y/n)'
    redraw
    let yn = nr2char(getchar())
    if yn == 'y'
        let l:message = ['ぼ', 'う', 'け', 'ん', 'の', 'し', 'ょ', 'を'
                        \, 'き', 'ろ', 'く', 'し', 'ま', 'し', 'た']
        try
            silent execute("w")
        catch
            let l:message = ['ぼ', 'う', 'け', 'ん', 'の', 'し', 'ょ', 'を',
                              \'き', 'ろ', 'く', 'で', 'き', 'ま', 'せ', 'ん', 'で', 'し', 'た']
        endtry
        "echo 'save'
        let &l:statusline = ''
        for m in l:message
            let &l:statusline .= m
            redraw
            sleep 100ms
        endfor
        sleep 200ms
        let while_return = &l:statusline
        while 1
            let loop = getchar(0)
            if loop != 0
                break
            endif
            let &l:statusline = &l:statusline == while_return ? &l:statusline . ' ⏎' : while_return
            redraw
            sleep 600ms
        endwhile
    elseif yn == 'n'
        echo 'non save'
    else
        echo 'error'
    endif
    let &l:statusline = s:status
    redraw
endfunction


