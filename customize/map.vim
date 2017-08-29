" normal mode
nnoremap // :<C-u>nohlsearch<CR><C-l>
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>Q :<C-u>quit!<CR>
nnoremap <Space>4 <S-$>
nnoremap <Space>; :

" FIXME:
nunmap <Space>w
nnoremap <Space>w :<C-u>update<CR>

" search after zz
nnoremap <silent> n nzz
nnoremap <silent> N Nzz


" insert mode
inoremap <silent> jj <Esc>


" TODO: plugin と当ファイルの読み込み順調査

" emmet mapping
if exists("g:loaded_emmet_vim")
    augroup EmmetMapping
        autocmd!
        autocmd BufRead,BufNewFile *.html,*.cshtml,*.tpl nnoremap<buffer> <Space>e :call emmet#expandAbbr(3,"")<CR>
        autocmd BufRead,BufNewFile *.html,*.cshtml,*.tpl vnoremap<buffer> <Space>e :call emmet#expandAbbr(2,"")<CR>
    augroup END
endif

" tenki
if exists("g:loaded_openbrowser")
    nnoremap <Space>t :call OpenBrowser('http://www.tenki.jp/forecast/5/26/5110/23100.html')<CR>
endif

