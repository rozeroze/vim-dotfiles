""" extension random


" unload
finish

" Random
function! Random(digit)
   return reltimestr(reltime())[-2:] % a:digit
endfunction
function! RandomBit()
   " return [01]
   return reltimestr(reltime())[-1:] % 2
endfunction
function! RandomDidit()
   " return [0-9]
   return reltimestr(reltime())[-1:]
endfunction


" vim: set ts=3 sts=3 sw=3 et :
