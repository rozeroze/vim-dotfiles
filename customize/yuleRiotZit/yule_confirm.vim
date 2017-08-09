" yule riot zit



" default setting
let g:yuleriotzit#statusline#confirm_interval = 100

command! -nargs=* YuleTest :call g:yuleriotzit#yule_confirm#confirm(<f-args>)
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
            elseif command == '' || command == ' '
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

