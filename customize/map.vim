" normal mode
"nnoremap ; :
"nnoremap : ;
nnoremap // :noh<CR>
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>Q :<C-u>quit!<CR>
nnoremap <Space>4 <S-$>
nnoremap <Space>; :

" insert mode
inoremap <silent> jj <Esc>

" unite.vim
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]f :<C-u>call ConfirmUnitFile()<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() " {{{
    " unite exit by ESC
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction " }}}
function! ConfirmUnitFile() " {{{
    if exists("g:loaded_netrwPlugin")
        if confirm("netrwがあるのにuniteを起動するのですか？", "はい\nいいえ")
            if confirm("netrwのほうが優秀ですよ？それでもuniteを起動しますか？", "はい\nいいえ")
                if confirm("やれやれ、ではuniteでよろしいのですね？主よ、罪深きものをお許しください", "はい\nいいえ")
                    " SORROW: 個人的にはuniteでも構わない
                    execute("Unite file")
                endif
            endif
        endif
    else
        execute("Unite file")
    endif
endfunction " }}}



" emmet mapping
"let fts = ['html', 'cshtml']
"if index(fts, &filetype) != -1
"    nnoremap <Space>e :call emmet#expandAbbr(3,"")<CR>
"    vnoremap <Space>e :call emmet#expandAbbr(2,"")<CR>
    "inoremap <Space>e <C-r>=emmet#util#closePopup()<CR><C-r>=emmet#expandAbbr(0,"")<CR>
"endif
autocmd BufRead,BufNewFile *.html,*.cshtml nnoremap<buffer> <Space>e :call emmet#expandAbbr(3,"")<CR>
autocmd BufRead,BufNewFile *.html,*.cshtml vnoremap<buffer> <Space>e :call emmet#expandAbbr(2,"")<CR>


" tenki
nnoremap <Space>t :call OpenBrowser('http://www.tenki.jp/forecast/5/26/5110/23100.html')<CR>

" むやみやたらと保存しまくる癖がある。なおせ
nunmap <Space>w
nnoremap <Space>w :<C-u>update<CR>



