""" Theme: task list
""" Summary: タスクリストをJsonで管理する
""" Version: 2018-10-01


if exists('g:loaded_task')
   finish
endif
let g:loaded_task = 1

let s:file = expand('~/vim-task.json')

function! s:Task()
   if !filereadable(s:file)
      echo 'fail: file not found, or unreadable. -task.vim'
      return
   endif
   let json = <sid>Decode(s:file)
   call <sid>Open()
   echo json
endfunction

function! s:Decode(file)
   try
      let text = join(readfile(a:file))
      let json = json_decode(text)
      return json
   catch /.*/
      return { 'error' : 'invalid read file or json decode.' }
   endtry
endfunction

function! s:Open()
   call execute('tabnew ' . s:file)
endfunction

command! Task :call <sid>Task()


" vim: set ts=3 sts=3 sw=3 et :
