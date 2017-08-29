" abbreviate settings
" Summary: help :abbreviate
" Authors: rozetoze <rosettastone1886@gmail.com>
" License: free MIT?
" Version: 1.0.1
" Last Change: 2017-08-29

augroup MyAbbreviates
    autocmd!
    autocmd FileType * call s:MyAbbreviateClear()
    autocmd FileType vim call s:MyAbbreviateVim()
    autocmd FileType cs call s:MyAbbreviateCSharp()
    autocmd FileType html,cshtml call s:MyAbbreviateHtml()
    autocmd FileType js call s:MyAbbreviateJavaScript()
    autocmd FileType python,py call s:MyAbbreviatePython()
    autocmd FileType rb call s:MyAbbreviateRuby()
    autocmd BufWinEnter schedule.txt ca u put =Strdate2unixtime('
    " ') this line is syntax correct
augroup END

function! s:MyAbbreviateClear()
    abclear " すべての ab を削除
endfunction
function! s:MyAbbreviateVim()
    ab ag augroup AutoGroupName<CR>autocmd!<CR>augroup END
endfunction
function! s:MyAbbreviateCSharp()
    ab gs; { get; set; }
endfunction
function! s:MyAbbreviateHtml()
    ab <> <!-- comment -->
    ab @@ @** comment **@
    ab @< @** <!-- comment --> **@
endfunction
function! s:MyAbbreviateJavaScript()
endfunction
function! s:MyAbbreviatePython()
endfunction
function! s:MyAbbreviateRuby()
    ab ++ += 1
endfunction

