" yule riot zit

" NOTE: YuleMessageではstatuslineを保持しない
command! -nargs=* YuleMessage :call g:yuleriotzit#yule_message#message(<f-args>)
function! g:yuleriotzit#yule_message#message(...) abort
    set nocursorline
    set nocursorcolumn
    if a:0 > 0
        let l:message = a:1
        let l:list = split(l:message, '\zs')
        let l:un_necessary = 0

        let &statusline = ''
        for c in l:list
            sleep 200ms
            let &statusline .= c
            redraw
            let l:un_necessary = getchar(0)
            if l:un_necessary
                let &statusline = l:message
                break
            endif
        endfor
        sleep 100ms
        let l:wait_hitkey = 1
        while l:wait_hitkey
            let l:wait_hitkey = !getchar(0)
            let &statusline = &statusline == l:message ? &statusline . ' .' : l:message
            redraw
            sleep 200ms
        endwhile
    endif
endfunction

command! YuleMessageTest :call s:yuleMessageTest()
function! s:yuleMessageTest()
    echo ''
    call g:yuleriotzit#yule_message#message('勇者『禿に用はないぜ』')
    call g:yuleriotzit#yule_message#message('国王からの呼出状を持参した城兵に、勇者は言った。')
    call g:yuleriotzit#yule_message#message('呼出を拒否するのは今月で７度目だった。')
    call g:yuleriotzit#yule_message#message('城兵『まあ、そういわずに。今度こそは勇者様も参加したくなると思いますよ』')
    call g:yuleriotzit#yule_message#message('勇者『ほう？』')
    call g:yuleriotzit#yule_message#message('勇者（……あの禿は何を企んでやがる）')
    call g:yuleriotzit#yule_message#message('城兵がもったいぶった動作で差し出した呼出状を、勇者はひったくった。')
    call g:yuleriotzit#yule_message#message('勇者『おいっ！この字、なんて読むんだ？』')
    call g:yuleriotzit#yule_message#message('城兵『それは……ふっ。ふふ、これが読めないのですか？』')
    call g:yuleriotzit#yule_message#message('勇者『いいから教えろ』')
    call g:yuleriotzit#yule_message#message('城兵の青い瞳が、そっと色を失った。唇が引き結ばれ、にぃっと笑みが浮かぶ。')
    call g:yuleriotzit#yule_message#message('城兵『ふふ、ふ』')
    call g:yuleriotzit#yule_message#message('失われた青の代わりに、蔑みの色が城兵の瞳に宿った。')
    call g:yuleriotzit#yule_message#message('城兵『どれ、すこし我が国の初等教育について、講義をいたしましょう』')
    call g:yuleriotzit#yule_message#message('勇者『そんなのはいらん』')
    call g:yuleriotzit#yule_message#message('城兵『いえ、必要になりますとも。きっとね』')
    call g:yuleriotzit#yule_message#message('国王よりも怖い城兵が微笑むと、勇者は口がきけなくなった。')
    set statusline&
endfunction
