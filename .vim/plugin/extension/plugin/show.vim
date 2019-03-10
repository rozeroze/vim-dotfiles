" Vim plugin script
" Summary: show variables
" Authors: rozeroze <rosettastone1886@gmail.com>
" Version: 2018-06-18


" MEMO: 簡易表示用
function! Show(...)
   let s:indent = 0
   for item in a:000
      call <SID>ShowItem(item)
   endfor
endfunction

function! s:ShowLine(text)
   echo printf("%s%s\n", repeat(' ', (&tabstop * s:indent)), a:text)
endfunction

function! s:ListStart()
   call <SID>ShowLine('[')
   let s:indent += 1
endfunction
function! s:ListFinish()
   let s:indent -= 1
   call <SID>ShowLine(']')
endfunction
function! s:DictStart()
   call <SID>ShowLine('{')
   let s:indent += 1
endfunction
function! s:DictFinish()
   let s:indent -= 1
   call <SID>ShowLine('}')
endfunction

function! s:ShowItem(item)
   if type(a:item) == v:t_number
      \ || type(a:item) == v:t_string
      \ || type(a:item) == v:t_float
      \ || type(a:item) == v:t_bool
      \ || type(a:item) == v:t_none
      call <SID>ShowLine(a:item)
   elseif type(a:item) == v:t_list
      call <SID>ListStart()
      for listitem in a:item
         call <SID>ShowItem(listitem)
      endfor
      call <SID>ListFinish()
   elseif type(a:item) == v:t_dict
      call <SID>DictStart()
      for key in keys(a:item)
         let text = printf('%s : %s', string(key), string(a:item[key]))
         call <SID>ShowItem(text)
      endfor
      call <SID>DictFinish()
   else
   endif
endfunction


" unload after
finish


function! Showlist(list)
   if type(a:list) != v:t_list
      echo 'type was invalid.'
      return
   endif
   let text = '[\n'
   for item in a:list
      let text += printf('%s\n', item)
   endfor
   let text += ']'
   echo text
   redraw
endfunction


" unload after
finish

let s:indent = 0
let s:text = ''

function! g:show(...)
   let s:indent = 0
   let s:text = ''
   " TODO: call Show(['first','second','third']) だとvarがlistになり
   "       listとstringの比較ができないとエラー
   "       再帰処理すればいけそう
   for var in a:000
      if var =~ '[[{]'
         let indent += count(split(var, '\zs'), '[')
         let indent += count(split(var, '\zs'), '{')
      endif
      if var =~ '[]}]'
         let indent -= count(split(var, '\zs'), ']')
         let indent -= count(split(var, '\zs'), '}')
      endif
      let text += printf('%s%s\n', repeat('  ', indent), var)
   endfor
   echo text
endfunction

function! s:Append(arg)
      let s:text += printf('%s%s\n', repeat('  ', s:indent), a:arg)
endfunction

function! s:Analysis(arg)
   if type(a:arg) == v:t_number
      call <SID>Append(string(a:arg))
   elseif type(a:arg) == v:t_string
      call <SID>Append(a:arg)
   elseif type(a:arg) == v:t_list
      for item in a:arg
         call <SID>Analysis(item)
      endfor
   elseif type(a:arg) == v:t_dict
      for key in keys(a:arg)
         call <SID>Analysis(printf('%s : %s', key, a:arg[key]))
      endfor
   elseif type(a:arg) == v:t_float
      call <SID>Append(string(a:arg))
   elseif type(a:arg) == v:t_bool
      call <SID>Append(string(a:arg))
   elseif type(a:arg) == v:t_none
      call <SID>Append(string(a:arg))
   else
      " v:t_func v:t_job v:t_channel
   endif
endfunction




" vim: set ts=3 sts=3 sw=3 et :
