" yule riot zit



" default setting
let g:yuleriotzit#statusline#confirm_interval = 100

command! -nargs=* YuleConfirm :call g:yuleriotzit#yule_confirm#confirm(<f-args>)
function! g:yuleriotzit#yule_confirm#confirm(...) abort
    if a:0 > 0
        let status = &statusline
        let message = a:1
        let choice_list =  a:000[1:]
        let choice_num = len(choice_list)

        let line = message . ': '
        let choice_index = 1

        let i = 1
        while len(choice_list)
            if choice_index == i
                let line .= '[' . remove(choice_list, 0) . ']'
            else
                let line .= ' ' . remove(choice_list, 0) . ' '
            endif
            let i += 1
        endwhile

        let &statusline = line
        redraw

        " choice
        while 1
            let command = nr2char(getchar())
            if command == '' || command == 'q'
                let &statusline = status
                return 0
            elseif command == 'h'
                let choice_index -= choice_index == 1 ? 0 : 1
            elseif command == 'l'
                let choice_index += choice_index == choice_num ? 0 : 1
            elseif command == '
' || command == ' '
                let &statusline = status
                return choice_index
            endif

            let choice_list =  a:000[1:]
            let line = message . ': '

            let i = 1
            while len(choice_list)
                if choice_index == i
                    let line .= '[' . remove(choice_list, 0) . ']'
                else
                    let line .= ' ' . remove(choice_list, 0) . ' '
                endif
                let i += 1
            endwhile

            let &statusline = line
            redraw
        endwhile

    else
        " no action
    endif
endfunction

command! YuleConfirmTest :call s:yuleConfirmTest()
function! s:yuleConfirmTest()
    echo ''
    let s:gender = g:yuleriotzit#yule_confirm#confirm('your gender', 'male', 'female')
    let s:age = g:yuleriotzit#yule_confirm#confirm('your age', 'over 20', 'under 20')
    if s:gender == 1 && s:age == 1
        echo 'you are man'
    elseif s:gender == 1 && s:age == 2
        echo 'you are boy'
    elseif s:gender == 2 && s:age == 1
        echo 'you are women'
    elseif s:gender == 2 && s:age == 2
        echo 'you are girl'
    endif
endfunction

