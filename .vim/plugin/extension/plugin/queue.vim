""" extension queue


" unload
finish

" Queue
function! Queue(...)
   let queue = { 'list': [] }
   if a:0 > 0
      "let queue.list = type(a:1) == v:t_list ? a:1 : a:000
      if type(a:1) == v:t_list
         let queue.list = a:1
      else
         let queue.list = a:000
      endif
   endif
   function! queue.enqueue(item) dict
      call add(self.list, a:item)
   endfunction
   function! queue.dequeue() dict
      let item = self.list[0]
      let self.list = self.list[1:]
      return item
   endfunction
   return queue
endfunction


" vim: set ts=3 sts=3 sw=3 et :
