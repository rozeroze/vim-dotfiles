""" visualization char


if exists('g:loaded_visualization')
   finish
endif
let g:loaded_visualization = 1


" MEMO: 下記の設定を前提にしている(色遣いなど)
"       set guifont=あんずもじ等幅:h12:cSHIFTJIS:qDRAFT
"       colorscheme frozendaiquiri

augroup VisualizeChar
   autocmd!
   autocmd BufWinEnter * :call <SID>VisualizeOn()
augroup END

function! s:VisualizeOn()
   " invisible
   syntax match MultiByteSpace /　/ conceal cchar=┿
   " highlight special-char
   highlight VisualizeColon     term=bold gui=bold guifg=#86b781
   highlight VisualizeSemicolon term=bold gui=bold guifg=#d67388
   highlight VisualizeComma     term=none gui=none guifg=#6298bf
   highlight VisualizePeriod    term=none gui=none guifg=#e2d76f
   let s:vcolon = matchadd('VisualizeColon',     '\U\zs:')
   let s:vsmcln = matchadd('VisualizeSemicolon', ';')
   let s:vcomma = matchadd('VisualizeComma',     ',')
   let s:vpriod = matchadd('VisualizePeriod',    '\.')
endfunction

function! s:VisualizeOff()
   highlight clear VisualizeColon
   highlight clear VisualizeSemicolon
   highlight clear VisualizeComma
   highlight clear VisualizePeriod
   call matchdelete(s:vcolon)
   call matchdelete(s:vsmcln)
   call matchdelete(s:vcomma)
   call matchdelete(s:vpriod)
endfunction


" vim: set ts=3 sts=3 sw=3 et :
