""" File: vimvc/view.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

function! vimvc#view#404()
   return [ '', '404 Page Not Found!', '' ]
endfunction

function! vimvc#view#index()
   return [
        \   'Welcome to VIMVC',
        \   '',
        \   'Content',
        \   ' - What is VIMVC',
        \   ' - Articles',
        \   '',
        \   'What is VIMVC',
        \   '  VIMVCとは、ソフトウェアアーキテクチャパターンの１つ',
        \   '  MVCをVimで再現した派生パターンであり、ある程度模倣されている',
        \   '  ServerはVimが担当し、ClientもVimが担当しているのが他にない特色である',
        \   '',
        \   'Articles',
        \   ' - all articles [link:list]',
        \   ' - about mvc    [link:mvc]',
        \   ' - usage        [link:usage]',
        \   ' - vim server   [link:clientserver]',
        \   ' - vim package  [link:package]'
        \ ]
endfunction

function! vimvc#view#list()
   return [
        \   'about mvc [link:mvc]',
        \   '  まずはMVCとは何かを理解する',
        \   '',
        \   'usage [link:usage]',
        \   '  VIMVCの使い方',
        \   '',
        \   'vim-feature clientserver [link:clientserver]',
        \   '  VimでMVCを再現するためにclientserverを利用する',
        \   '',
        \   'vim-feature package [link:package]',
        \   '  VIMVCはpackageにて管理されている'
        \ ]
endfunction

function! vimvc#view#mvc()
   return [
        \   'MVC (Model-View-Controller) とは、アプリケーションを実装するための',
        \   'デザインパターンの１つ',
        \   '',
        \   'MVCのそれぞれについて',
        \   '  Model: ビジネスロジックの実装',
        \   '  View: UI/ユーザが表示するもの',
        \   '  Controller: クライアントからの入力を受け付け、Viewを返す',
        \   '',
        \   'ありていにいえば上記の通り',
        \   'もし詳細が知りたければ下記URLを参照のこと',
        \   '  wikipedia: https://ja.wikipedia.org/wiki/Model_View_Controller'
        \ ]
endfunction

function! vimvc#view#usage()
   return [
        \   'USAGE < VIMVCの使い方 >',
        \   '',
        \   'まずは実行する',
        \   '  1. vimrcに"packadd vimvc"を追加する',
        \   '  2. "vim --servername VIMVCSERVER"にてVIMVC専用のサーバを起動',
        \   '  3. client用にvimを起動し、":VIMVC"コマンドをkick!',
        \   '',
        \   'ここまでで、client-vimにindexページが表示される',
        \   'VIMVCはサーバサイドとクライアントサイドの2つに分けられ、',
        \   'クライアントサイドは更に2系統の機能に分けられる',
        \   'これらはそれぞれNumberとStringにhighlight-linkされている',
        \   '',
        \   'Link',
        \   '  ご覧のindexに[link:list]のようなテキストを見ることができるだろう',
        \   '  これはブラウザでいうanchor-linkの事であり',
        \   '  これをクリックするとlistページにリンクすることができる',
        \   '  お使いのVimのNumberにhighlight-linkされている',
        \   '',
        \   'Action',
        \   '  [link:list]と似たような形で[action:search]を見つけられるだろう',
        \   '  これはブラウザでいうformやsubmitの事であり、',
        \   '  これらと似たような機能を提供する',
        \   '  クリックすると、コマンドラインがアクティブになり入力受付モードになる',
        \   '  ここで入力した内容でサーバにアクセスし、結果を得ることができる',
        \   '  [action:search]では入力内容が含まれるページへのリンク一覧を表示する',
        \   '  お使いのVimのStringにhighlight-linkされている',
        \   '',
        \   'Server',
        \   '  client-vimでlinkやactionを適当にクリックすると',
        \   '  server-vimにテキストが追加されるのに気付いただろうか？',
        \   '  これはWebサーバでよくあるlog機能を再現したものであり',
        \   '  client-vimからどのようなアクセスがあったかを記録している',
        \   '  server-vim専用のコマンドが2つ用意されている',
        \   '  :Reboot',
        \   '    server-vimをリブートする',
        \   '    logがリセットされ、server-vimに必要な各ファイルを再読込する',
        \   '  :Down',
        \   '    server-vimをシャットダウンする',
        \   '  また、現在そのような機能はないし、開発する予定もないが、',
        \   '  server-vimのbufferにあるlogを実ファイルに書き出す機能を作るかもしれない',
        \   '  ……作らないかもしれない'
        \ ]
endfunction

function! vimvc#view#clientserver()
   return [
        \   'あまり知られていないが、Vimにはサーバモードがあり、',
        \   'クライアントからメッセージを受け取り実行する機能がある',
        \   '',
        \   'VIMVCもこの機能を利用している',
        \   ':help clientserver'
        \ ]
endfunction

function! vimvc#view#package()
   return [
        \   'VimPluginの活用はVimmerのVimLifeを豊かにするが、',
        \   'VimPluginManagerの活用について筆者は快く思っていない',
        \   '',
        \   'Vim8.0になってPackage機能が標準搭載された',
        \   '標準で用意された機能なら、と思いVIMVCはpackageとして開発した',
        \   ':help packages'
        \ ]
endfunction

" vim: set ts=3 sts=3 sw=3 et :
