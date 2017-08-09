" abbreviate settings
" Summary: help :abbreviate
" Authors: rozetoze <rosettastone1886@gmail.com>
" License: free MIT?
" Version: 1.0.0
" Last Change: 2017-08-09

" test
"ab #r #region

augroup MyAbbreviates
    autocmd!
    autocmd FileType * call s:MyAbbreviateClear()
    autocmd FileType vim call s:MyAbbreviateVim()
    autocmd FileType cs call s:MyAbbreviateCSharp()
    autocmd FileType html, cshtml call s:MyAbbreviateHtml()
    autocmd FileType js call s:MyAbbreviateJavaScript()
augroup END

function! s:MyAbbreviateClear()
    abclear " すべての ab を削除
endfunction
function! s:MyAbbreviateVim()
    "ab f! function!
    ab ag augroup AutoGroupName<CR>autocmd!<CR>augroup END
endfunction
function! s:MyAbbreviateCSharp()
    "ab psv public static void
    ab gs; { get; set; }
endfunction
function! s:MyAbbreviateHtml()
    ab // <!-- comment -->
    ab @@ @** comment **@
endfunction
function! s:MyAbbreviateJavaScript()
endfunction

