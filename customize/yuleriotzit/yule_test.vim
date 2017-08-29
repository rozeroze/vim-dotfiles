" yule riot zit

command! YuleTest :call s:yuleTest()
function! s:yuleTest()
    echo ''
    let g:yuleriotzit#yule_test#quittimer = timer_start(100, 'QuitAnyTime', { 'repeat': -1 })

    call g:yuleriotzit#yule_titlecall#titlecall('YULE TEST')
    call g:yuleriotzit#yule_message#message('this is yule test.')
    call g:yuleriotzit#yule_message#message('at first, are you know yule meaning?')
    let s:age = g:yuleriotzit#yule_confirm#confirm('yule mean know', 'yes', 'no')
    if s:age == 2 " no
        call g:yuleriotzit#yule_message#message('yule mean...')
        call g:yuleriotzit#yule_message#message('sorry, i cant answer yet.')
        call g:yuleriotzit#yule_message#message('if you wanna, you play yule!')
    endif

    call g:yuleriotzit#yule_message#message('...')
    call g:yuleriotzit#yule_message#message('you moved castle')
    call g:yuleriotzit#yule_message#message('rook1: Hey! look at! Its enemy')
    call g:yuleriotzit#yule_message#message('rook2: What? OMG! We have no force now.')
    call g:yuleriotzit#yule_message#message('rook1: Shit! we fight enemy without our force')
    call g:yuleriotzit#yule_message#message('rook1: our force come at soon. be wait.')
    call g:yuleriotzit#yule_message#message('rook2: OK! got it')


    call g:yuleriotzit#yule_titlecall#titlecall('BATTLE')
    if g:yuleriotzit#yule_battle#battle('a word to the wise is sufficient', 20) == 0
        call g:yuleriotzit#yule_titlecall#titlecall('YOU LOSE')
        call g:yuleriotzit#yule_message#message('rook2: Hey! stand up. please live again... oh, my friend...')
        set statusline&
        return
    endif

    call g:yuleriotzit#yule_message#message('rook1: good fight! we kick about enemies!')
    call g:yuleriotzit#yule_message#message('rook2: And, our force come here. we live')

    call g:yuleriotzit#yule_message#message('the yule test finished. thank you...')

    set statusline&
endfunction

" TODO: 他の方法を考える
" if nr2char(getchar(0)) == '' | set statusline& | return | endif を一行ごとに入れなくて済む方法を
function! QuitAnyTime(timer) abort
    let s:input = nr2char(getchar(0))
    if s:input == ''
        call timer_stop(g:yuleriotzit#yule_test#quittimer)
        " 実行中の関数 's:yuleTest()' を外部から終了させる方法ってないかな
        set statusline&
        return
    endif
endfunction
