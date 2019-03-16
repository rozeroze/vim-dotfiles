""" Theme: column highlight marker
""" Summary: colorcolumnをセットする
""" Version: 2019-02-15


" MEMO: multibyte-characterがあると列がずれる
" MEMO: col('.')だと桁の実値を変えすが、getcurpos()なら表示上の桁値を返す
"  -> 修正 2019-02-15

if exists('g:loaded_chilimarker')
   finish
endif
let g:loaded_chilimarker = 1

let s:offset = 0

nnoremap <nowait><silent> <space>c :<c-u>call <sid>cc()<cr>
nnoremap <nowait><silent> <space><space>c :set colorcolumn&<cr>

function! s:cc()
   let list = split(&colorcolumn, ',')
   "let col = col('.') + s:offset . ''
   let col = getcurpos()[4] + s:offset . ''
   if count(list, col)
      call remove(list, index(list, col))
   else
      call add(list, col)
   endif
   let &l:colorcolumn = join(list, ',')
endfunction

" vim: set ts=3 sts=3 sw=3 et :
