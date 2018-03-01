""" vimscript run soon


if exists('g:loaded_runsoon')
   finish
endif
let g:loaded_runsoon = 1

command -range -nargs=? RunSoon :call <SID>RunSoon(<count>, <line1>, <f-args>)
function! s:RunSoon(...)
   let withv = a:1
   let lion = a:2
   let arg = len(a:000[2:]) ? a:3 : ''
   if withv == -1
      let script = s:GetLine(lion)
   else
      let script = s:GetRange(lion, withv)
   endif
   if !arg
      execute script
      return
   endif
   " other script type
   if arg =~# '-\?py\(thon\)\?'
      if !has('python') && !has('python3')
         echo 'not support python'
         return
      endif
      let script = "pythonx << EOF\n" . script . "\nEOF"
   elseif arg =~# '-\?(rb|ruby)'
      "execute '!ruby ' . script
      echo 'TODO: support ruby'
   else
      echo 'argument error: ' . arg . ' is denied'
   endif
endfunction

function! s:GetLine(lion)
   return getline(a:lion)
endfunction

function! s:GetRange(lion, lien)
   let tmp = @r
   silent norm! gv"ry
   let ret = @r
   let @r = tmp
   return ret
endfunction


finish

""" help
RunSoon()関数内でexecuteしているので、
下記の行でRunSoonしても意味ないです
  let test = 'this is test'
変数testに値を入れたいのならば
  let g:test = 'this is test'
と、明示的なスコープ宣言が必要になるです
" MEMO: help func-closure
closure指定をいれると関数外へのアクセスが可能になる?
……後で調査しよう



" vim: set ts=3 sts=3 sw=3 et :
