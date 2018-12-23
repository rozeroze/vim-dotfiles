" vim filetype plugin file
" FileType: chatwork
" Maintainer: rozeroze <rosettastone1886@gmail.com>
" Last Change: 2018 Feb 2


if exists('b:did_ftplugin')
   finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

""" setlocal
setlocal bufhidden=hide
setlocal buftype=nofile
setlocal nobuflisted
setlocal noreadonly
setlocal noswapfile


""" completion
nnoremap <buffer> [chatwork] <Nop>
nmap <buffer> <LocalLeader> [chatwork]
imap <buffer> <LocalLeader> [chatwork]
" complete to
nnoremap <buffer><silent> [chatwork]t i<C-R>=ChatworkCompleteTo()<CR>
inoremap <buffer><silent> [chatwork]t <C-R>=ChatworkCompleteTo()<CR>
function! ChatworkCompleteTo()
   " TODO: git管理外ファイルから読み込めるようにする
   " let g:chatwork_completion_user = [ { 'word': '[TO:1234]', 'abbr': 'ROZEROZE' } ]
   call complete(col('.'), [
            \ { 'word': '[TO:1111]', 'abbr': 'John' },
            \ { 'word': '[TO:2222]', 'abbr': 'Michel' },
            \ { 'word': '[TO:3333]', 'abbr': 'Judy' },
            \ { 'word': '[TO:4444]', 'abbr': 'Alex' }
            \ ])
   return ''
endfunction
" complete tag-code
nnoremap <buffer><silent> [chatwork]c i<C-R>=ChatworkCompleteTagCode()<CR>
inoremap <buffer><silent> [chatwork]c <C-R>=ChatworkCompleteTagCode()<CR>
function! ChatworkCompleteTagCode()
   call complete(col('.'), [
            \ { 'word': '[code][/code]', 'abbr': 'code' },
            \ { 'word': '[hr]', 'abbr': 'line' },
            \ { 'word': '[info][/info]', 'abbr': 'info' },
            \ { 'word': '[info][title][/title][/info]', 'abbr': 'info-title' }
            \ ])
   return ''
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: set ts=3 sts=3 sw=3 et tw=0 fdm=marker :
