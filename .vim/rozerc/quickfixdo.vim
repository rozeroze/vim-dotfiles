""" do like argdo on quickfix-list


if exists('g:loaded_quickfixdo')
   finish
endif
let g:loaded_quickfixdo = 1

" practical vim tip96
" https://github.com/nelstrom/vim-qargs

command! -nargs=0 -bar Qargs execute 'args' <SID>QuickfixFilenames()
function! s:QuickfixFilenames()
   let buffer_numbers = {}
   for quickfix_item in getqflist()
      let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
   endfor
   return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


" vim: set ts=3 sts=3 sw=3 et :
