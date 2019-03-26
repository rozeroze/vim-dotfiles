""" search extend within visual-mode


if exists('g:loaded_visualsearch')
   finish
endif
let g:loaded_visualsearch = 1

xnoremap * :<c-u>let [@/, v:hlsearch] = <sid>VisualSearch('*')<cr>
xnoremap # :<c-u>let [@/, v:hlsearch] = <sid>VisualSearch('#')<cr>

function! s:VisualSearch(cmd)
   let temp = @s
   norm! gv"sy
   let ret = '\V' . substitute(escape(@s, a:cmd . '\'), '\n', '\\n', 'g')
   let @s = temp
   return [ret, v:true]
endfunction


finish
" refrence by Practical Vim TIP 86
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
   let temp = @s
   norm! gv"sy
   let @/ = '\V'. substitute(escape(@s, a:cmdtype. '\'), '\n', '\\n', 'g')
   let @s = temp
endfunction


" vim: set ts=3 sts=3 sw=3 et :
