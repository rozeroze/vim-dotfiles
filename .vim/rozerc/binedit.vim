""" Theme: read/write binary file
""" Summary: *.bin *.exe etc... xxd convert
""" Version: 2018-08-29


if exists('g:loaded_binedit')
   finish
endif
let g:loaded_binedit = 1

augroup BinEdit
   autocmd!
   autocmd BufReadPre   *.bin,*.exe let &bin=1
   autocmd BufReadPost  *.bin,*.exe if &bin | %!xxd
   autocmd BufReadPost  *.bin,*.exe set ft=xxd | endif
   autocmd BufWritePre  *.bin,*.exe if &bin | %!xxd -r
   autocmd BufWritePre  *.bin,*.exe endif
   autocmd BufWritePost *.bin,*.exe if &bin | %!xxd
   autocmd BufWritePost *.bin,*.exe set nomod | endif
augroup END

" bin,exe以外のbinaryファイル
command BinEdit :call <sid>BinEdit()
function! s:BinEdit()
   " XXX: fileを開く前に&binをセットしたいし、保存するときにxxdで再処理したい
   e ++bin
   if &bin
      %!xxd
      set filetype=xxd
   endif
   autocmd BufWritePre <buffer> if &bin | %!xxd -r | endif
   autocmd BufWritePost <buffer> if &bin | %!xxd | set nomodified | endif
endfunction


" vim: set ts=3 sts=3 sw=3 et :
