""" Theme: mapping
""" Version: 2018-12-17


" zp 対応するmatchpairを探し、pair間のコードが中間になるように再描画する
" MEMO: カーソル行から中間行までが画面に表示しきれない場合は
"       カーソル行が中間になるように再描画される
"       'scrolloff'などのオプションが優先される
" MEMO: help 'z' にzから始まるコマンドの一覧がある、
"       zpが開いていたのでparen基準の再描画を実装
" ATTENTION: このコマンドは'if'や'function'の上では動作しない
"            'if'や'function'の上で'%'が動作するのはmatchitという標準プラグインの
"            機能であり、私の関知するところではない
nnoremap <nowait><silent> zp :call <sid>z_paren()<cr>
function! s:z_paren()
   let curpos = getcurpos()
   let cursorchar = matchstr(getline('.'), '.', col('.') - 1)
   let lines = [ line('.'), 0 ]
   let skip = ''
   if exists("b:match_skip")
      let skip = b:match_skip
   else
      let skip = 'synIDattr(synID(line("."), col("."), 0), "name") =~? "comment\\|string"'
   endif
   for pair in split(&matchpairs, ',')
      let [ ps, pe ] = split(pair, ':')
      if cursorchar == ps
         let lines[1] = searchpair(ps, '', pe, 'n', skip)
         break
      endif
      if cursorchar == pe
         let lines[1] = searchpair(ps, '', pe, 'nb', skip)
         break
      endif
   endfor
   if lines[1] == 0
      " not found
      return
   endif
   call execute((lines[0] + lines[1]) / 2)
   normal! zz
   call setpos('.', curpos)
endfunction


" gh カーソル下の文字のハイライト情報を表示する
" MEMO: ga/:asciiコマンドにてカーソル位置の文字の文字コードを表示する
"       ghではカーソル位置の文字に適用されているhighlight情報を表示する
" ATTENTION: help gh -> 文字選択モードを開始する [ 既存の動作を上書きする ]
"            私はこれを使わないし、使いそうなプラグインをインストールする予定もない
nnoremap <nowait><silent> gh :call <sid>g_highlight()<cr>
command! HiCursor :call <sid>g_highlight()
function! s:g_highlight()
   " TODO: develop
   let char = matchstr(getline('.'), '.', col('.') - 1)
   let id = synID(line('.'), col('.'), 1)
   if id == 0
      echo 'NUL'
      return
   endif
   let name = synIDattr(id, 'name')
   let tid = synIDtrans(id)
   if tid == 0
      echo printf('<%s> %s, %s', char, id, name)
      return
   endif
   let fg = synIDattr(tid, 'fg#')
   let fg = fg != '' ? fg : 'NONE'
   let bg = synIDattr(tid, 'bg#')
   let bg = bg != '' ? bg : 'NONE'
   echo printf('<%s> %s, %s, fg:%s, bg:%s', char, id, name, fg, bg)
endfunction


" move to .vimrc
finish


" basic
"nnoremap <silent> // :<C-u>nohlsearch<CR>
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space><Space>w :<C-u>write!<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space><Space>q :<C-u>quit!<CR>
nnoremap <Space><Space><Space>q :<C-u>quitall!<CR>
nnoremap <Space>4 <S-$>
nnoremap <Space>5 <S-%>
nnoremap <Space>; :

" toggle highlight-search
nnoremap <silent> // :<C-u>let v:hlsearch = !v:hlsearch<CR>

" command-line-window open from command-mode
"cnoremap <up> <C-f>
"cnoremap <down> <C-f>

" search by 'very magic' always
"nnoremap <nowait> / /\v
"nnoremap <nowait> ? ?\v
nnoremap / /\v
nnoremap ? ?\v

" search under cursor without move
"nnoremap * :let @/ = '\<' . expand('<cword>') . '\>'<cr>
"nnoremap # :let @/ = '\<' . expand('<cword>') . '\>'<cr>
nnoremap <silent> * :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> # :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> g* :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
nnoremap <silent> g# :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>

" indent format
vnoremap < <gv
vnoremap > >gv

" TODO: plugin と当ファイルの読み込み順調査
" loadplugins' なんていうoption もあるくらいだから vimrc が先に読まれているはず
" 暫定的な解決 プラグインのロードを要確認
" おそらくafterディレクトリを上手く使うんだと思う
" .vim/after/plugin/map.vim を作成し、そこに定義した→動いた

" emmet mapping
"if exists("g:loaded_emmet_vim")
   augroup EmmetMapping
      autocmd!
      autocmd BufRead,BufNewFile *.html,*.cshtml,*.tpl nnoremap<buffer> <Space>e :call emmet#expandAbbr(3,"")<CR>
      autocmd BufRead,BufNewFile *.html,*.cshtml,*.tpl vnoremap<buffer> <Space>e :call emmet#expandAbbr(2,"")<CR>
   augroup END
"endif

" tenki
"if exists("g:loaded_openbrowser")
"   nnoremap <Space>t :call OpenBrowser('http://www.tenki.jp/forecast/5/26/5110/23100.html')<CR>
"endif
nnoremap <space>t :call <sid>t()<cr>
function! s:t()
   if exists('*OpenBrowser')
      call OpenBrowser('http://www.tenki.jp/forecast/5/26/5110/23100.html')
   endif
endfunction

" vim: set ts=3 sts=3 sw=3 et :
