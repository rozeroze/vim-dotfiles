""" Theme: fix, part of registers
""" Summary: registerの一部を固定する
""" Authors: rozeroze <rosettastone1886@gmail.com>
""" License: unknown
""" Version: 2018-06-20


if exists('g:loaded_fixregister')
   finish
endif
let g:loaded_fixregister = 1


" variable
let s:regist = {}
let s:regist.filename = v:false
let s:regist.filepath = v:true
let s:regist.extension = v:true


" functions
function! s:SetAuGroup()
   let ag = ['augroup fixregister', 'autocmd!']
   if s:regist.filename
      let ag += ['autocmd BufEnter * :let @f = @%']
   endif
   if s:regist.filepath
      let ag += ["autocmd BufEnter * :let @p = expand('%:p')"]
   endif
   if s:regist.extension
      let ag += ["autocmd BufEnter * :let @e = expand('%:e')"]
   endif
   let ag += ['augroup END']
   call execute(ag)
endfunction
function! s:SetOption(opt)
   let value = v:true
   let option = a:opt
   if a:opt[:1] == 'no'
      let value = v:false
      let option = a:opt[:1]
   endif
   let s:regist[option] = value
endfunction
function! s:IsOpt(opt)
   let list = keys(s:regist)
   call extend(list, map(list, '"no" . v:val'))
   let count = count(list, a:opt)
   if count == 0
      return v:false
   endif
   if count == 1
      return v:true
   endif
   " count > 1
   echo 'error: option was duplicated. -fixregister.vim'
   return v:false
endfunction
function! s:FixRegister(...)
   for arg in a:000
      if <SID>IsOpt(arg)
         call <SID>SetOption(arg)
      endif
   endfor
   call <SID>SetAuGroup()
endfunction


" command
command! -nargs=* FixRegister :call <SID>FixRegister(<f-args>)

" init starter
call <SID>FixRegister()


" vim: set ts=3 sts=3 sw=3 et :
