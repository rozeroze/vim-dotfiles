" yule riot zit


let g:yuleriotzit#statusline#titlecall_interval = 300

command! -nargs=* YuleTitleCall :call g:yuleriotzit#yule_titlecall#titlecall(<f-args>)
function! g:yuleriotzit#yule_titlecall#titlecall(...) abort
    if a:0 > 0
        let s:title = a:1
        let s:fmttitle = join(split(s:title, '\zs'), ' ')
        let s:titlelen = len(s:title)
        let s:fmttitlelen = len(s:fmttitle)
        let s:width = winwidth(0)

        let s:margin = (s:width - s:fmttitlelen) / 2

        let &l:statusline = repeat(' ', s:margin)
        for c in split(s:title, '\zs')
            let &l:statusline .= c . ' '
            redraw
            execute('sleep ' . g:yuleriotzit#statusline#titlecall_interval . 'ms')
        endfor

    endif
endfunction
