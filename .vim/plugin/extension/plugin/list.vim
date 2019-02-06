""" extension list


" unload
"finish

" circularly-linked list
function! Circularly(...)
   let circularly = { 'list': [] }
   if a:0 > 0
      if type(a:1) == v:t_list
         let circularly.list = a:1
      else
         let circularly.list = a:000
      endif
   endif
   " リストの先頭に追加
   function! circularly.insert(item) dict
      call insert(self.list, a:item, 0)
   endfunction
   " リストの末尾に追加
   function! circularly.add(item) dict
      call add(self.list, a:item)
   endfunction
   function! circularly.remove(idx) dict
      call remove(self.list, a:idx)
   endfunction
   " 末尾の要素を先頭に移動
   " ex) [ 1 , 2 , 3, 4 ] -> [ 4 , 1 , 2, 3 ]
   function! circularly.prev(...) dict
      let loop = a:0 == 0 ? 1 : a:1
      if loop == 0 | return | endif
      if loop < 0 | call self.next(abs(loop)) | return | endif
      while loop
         let self.list = insert(self.list[: -2], self.list[-1], 0)
         let loop -= 1
      endwhile
   endfunction
   " 先頭の要素を末尾に移動
   " ex) [ 1 , 2 , 3 , 4 ] -> [ 2 , 3 , 4 , 1 ]
   function! circularly.next(...) dict
      let loop = a:0 == 0 ? 1 : a:1
      if loop == 0 | return | endif
      if loop < 0 | call self.prev(abs(loop)) | return | endif
      while loop
         let self.list = add(self.list[1:], self.list[0])
         let loop -= 1
      endwhile
   endfunction
   return circularly
endfunction

finish

" List Shuffle
function! Shuffle(list)
   return sort(deepcopy(a:list), 'ListEasyShuffleFunc')
endfunction
function! ListEasyShuffleFunc(a, b)
   let rand = Random(13) - 6
   return rand
endfunction
function! ListHashShuffleFunc(a, b)
   let hash_a = sha256(string(a:a))
   let hash_b = sha256(string(a:b))
   return hash_a < hash_b
endfunction


" vim: set ts=3 sts=3 sw=3 et :
