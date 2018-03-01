""" extension stack


" unload
finish

" Stack
function! Stack(...)
   let stack = { 'list': [] }
   if a:0 > 0
      if type(a:1) == v:t_list
         let stack.list = a:1
      else
         let stack.list = a:000
      endif
   endif
   function! stack.push(item) dict
      call add(self.list, a:item)
   endfunction
   function! stack.pop() dict
      let item = self.list[-1]
      let self.list = self.list[: -2]
      return item
   endfunction
   function! stack.peek() dict
      return self.list[-1]
   endfunction
endfunction


" vim: set ts=3 sts=3 sw=3 et :
