""" File: doteditor.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-20
""" Description: おえかき

""" lancher
" function! doteditor#launch(...) {{{
function! doteditor#launch(...)
   call doteditor#open()
   call doteditor#init(a:000)
   call doteditor#cell()
   call doteditor#canvas()
   call doteditor#slosh(t:base)
endfunction
" }}}

""" initialize
" function! doteditor#open() {{{
function! doteditor#open()
   if !has_key(g:doteditor, 'counter') || type(g:doteditor.counter) != v:t_number
      let g:doteditor.counter = 1
   endif
   execute printf('tabnew [doteditor%d]', g:doteditor.counter)
   setlocal filetype=doteditor
   set showtabline=0 laststatus=0 cmdheight=1
   set scrolloff=0 sidescrolloff=0
   set linespace=0
   let g:doteditor.counter += 1
endfunction
" }}}
" function! doteditor#init(args) {{{
function! doteditor#init(args)
   let t:cell = 8
   let t:hrzn = 40
   let t:vert = 40
   let t:name = 'doteditor'
   let t:base = 'w'
   let t:pltt = v:false
   let t:colo = 'B'
   let i = 0
   while i < len(a:args)
      let _arg = a:args[i]
      if _arg =~? '^c\d\+$' || _arg =~? '^cell:\d\+&'
         let t:cell = matchstr(_arg, '\d\+')
      elseif _arg =~? '^h\d\+$' || _arg =~? '^horizon:\d\+$'
         let t:hrzn = matchstr(_arg, '\d\+')
      elseif _arg =~? '^v\d\+$' || _arg =~? '^vertical:\d\+$'
         let t:vert = matchstr(_arg, '\d\+')
      elseif _arg =~? '^s\d\+$' || _arg =~? '^square:\d\+$'
         let t:hrzn = matchstr(_arg, '\d\+')
         let t:vert = matchstr(_arg, '\d\+')
      elseif _arg =~? '^name:\w\+$'
         let t:name = matchstr(_arg, ':\zs\w\+')
      elseif _arg =~? '^base:\w\+$'
         let t:base = matchstr(_arg, ':\zs\w\+')
      "elseif _arg =~? '^p$' || _arg =~? '^palette$'
      "   let i += 1
      "   if a:args[i] == 'on'
      "      let t:pltt = v:true
      "   elseif a:args[i] == 'off'
      "      let t:pltt = v:false
      "   endif
      endif
      let i += 1
   endwhile
endfunction
" }}}
" function! doteditor#cell() {{{
function! doteditor#cell()
   " guifontに複数セットされている場合はsplit()で配列にして対応する
   let &guifont .= printf(':h%s:w%s', t:cell, t:cell)
endfunction
" }}}
" function! doteditor#canvas() {{{
function! doteditor#canvas()
   let &columns = t:hrzn
   let &lines = t:vert + 1 " offset cmdheight
endfunction
" }}}
" function! doteditor#slosh(char) {{{
function! doteditor#slosh(char)
   silent normal! ggdG
   call append(0, repeat([repeat(a:char, t:hrzn)], t:vert))
   silent normal! Gddgg
endfunction
" }}}
" function! doteditor#palette() {{{
function! doteditor#palette()
   if t:pltt
      return
   endif
   let t:pltt = v:true
   let &columns += 11
   10vnew [palette]
   setlocal filetype=dotpalette
   set showtabline=0 laststatus=0
   set scrolloff=0 sidescrolloff=0
   set linespace=0
   set winwidth=10
   silent normal! ggdG
   call append(0, ['B: Black', 'b: Blue', 'r: Red', 'm: Magenta', 'l: Lime', 'c: Cyan', 'y: Yellow', 'w: White'])
   silent normal! Gddgg
endfunction
" }}}

""" commands
" function! doteditor#help() {{{
function! doteditor#help()
   redraw
   echo join(['?  Show help',
            \ 'B  Change the color to black',
            \ 'b  Change the color to blue',
            \ 'r  Change the color to red',
            \ 'm  Change the color to magenta',
            \ 'l  Change the color to lime',
            \ 'c  Change the color to cyan',
            \ 'y  Change the color to yellow',
            \ 'w  Change the color to white',
            \ 'e  Erase the color',
            \ '#  All clear',
            \ '$  Capture color, under the cursor',
            \ '+  Enlarge the bit size',
            \ '-  Shrink the bit size',
            \ '.  Generate bitmap file',
            \ '*  Generate gif file'
            \], "\n")
endfunction
" }}}
" function! doteditor#draw() {{{
function! doteditor#draw()
   if bufname('%') =~? 'doteditor'
      echo 'doteditor draw'
      call execute(printf('silent normal! r%s', t:colo))
      redraw
   elseif bufname('%') =~? 'palette'
      echo 'dotpalette draw'
   endif
endfunction
" }}}
" function! doteditor#change(char) {{{
function! doteditor#change(char)
   let t:colo = a:char
   while v:true
      if bufname('%') =~? 'doteditor'
         sleep 5ms
         break
      endif
      normal! 
   endwhile
endfunction
" }}}
" function! doteditor#clear() {{{
function! doteditor#clear()
   normal! ggvGr 
endfunction
" }}}
" function! doteditor#capture() {{{
function! doteditor#capture()
   let t:colo = getline('.')[col('.') - 1]
endfunction
" }}}
" function! doteditor#enlarge() {{{
function! doteditor#enlarge()
   let t:cell += 1
   call doteditor#cell()
endfunction
" }}}
" function! doteditor#shrink() {{{
function! doteditor#shrink()
   let t:cell -= 1
   call doteditor#cell()
endfunction
" }}}
" function! doteditor#bitmap() {{{
function! doteditor#bitmap()
   if !has_key(g:doteditor, 'bitmap_generatable') || type(g:doteditor.bitmap_generatable) != v:t_bool
      let g:doteditor.bitmap_generatable = v:false
   endif
   while g:doteditor.bitmap_generatable == v:true
      if !has_key(g:doteditor, 'bitmap_generator_path') || type(g:doteditor.generator_path) != v:t_string
         let g:doteditor.bitmap_generatable = v:false
         break
      endif
      let g:doteditor.bitmap_generator_path = exepath(g:doteditor.bitmap_generator_path)
      if !executable(g:doteditor.bitmap_generator_path)
         let g:doteditor.bitmap_generatable = v:false
         break
      endif
      if !has_key(g:doteditor, 'bitmap_generator_prg') || type(g:doteditor.generator_prg) != v:t_string
         let g:doteditor.bitmap_generatable = v:false
         break
      endif
      break
   endwhile
   if g:doteditor.bitmap_generatable == v:false
      let g:doteditor.bitmap_generator_path = ''
      let g:doteditor.bitmap_generator_prg = ''
      echo 'fail: bitmap generator is not executable. -doteditor.vim'
      return
   endif
   let cmd = printf('!%s %s', g:doteditor.bitmap_generator_path, join(map(deepcopy(g:doteditor.bitmap_generator_prg), 'eval(v:val)')))
endfunction
" }}}
" function! doteditor#gif() {{{
function! doteditor#gif()
endfunction
" }}}
" function! doteditor#generate() {{{
function! doteditor#generate()
   let generator = expand('D:/workmemory/csharp/bitmap/doteditor_gen.exe')
   let name = input('filename: ')
   let data = getline(1, '$')
   let command = printf('!%s %s %s %s %s', generator, name, t:vert, t:hrzn,
            \ join(map(data, {idx, val -> '"' . val . '"'}))
            \ )
   call execute(command)
endfunction
" }}}


" vim: set ts=3 sts=3 sw=3 et :
