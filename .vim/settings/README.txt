==============================================================================
                                     README
==============================================================================

# Summary
個人用のscriptフォルダ
plugin形式にするほどではないscriptや、map等の些少な設定をファイル単位に
分割してここに管理する
あとは（といってもこれが本題だが）、ちょっとしたお遊びscriptを適当に
放り込んでいる
ディレクトリ名をsettingsではなくpluginにすれば.vimrcで明示せずとも
loadされるはずだが、pluginという感じではないためsettingsという名前にした


# Rule of
scriptファイルの命名規則
・許される文字は[a-z0-9]と記号_(underscore)のみ
・基本的に[a-z]のみで命名するのが望ましい


# Variable
global空間を汚染しすぎないようにする
let g:rzrz = {}
をsource settings/*する前に定義する
ex: testに設定値を渡すなら、下記の通りに
let g:rzrz.test = { 設定値 }


# Git
現状、自分のメインPCのOSがgitというかアプリケーションに対応していないため、
まだGit管理しておらず、そのうちGit管理する予定


# ファイル詳細 2018/2/19
abbreviate.vim	短縮入力(after/ftplugin移行予定)
buffer-list.vim	buffer-listからVimで開く
chess.vim	chessができる
chessboard.vim	chessboardのみ、棋譜ならべとか
completechar.vim	特殊文字の入力補助
create-colorscheme.vim	colorschemeの簡易作成
goat.vim	go to file
investor.vim	株情報をWebApiから(保留)
linkage.vim	外部Appを叩く
loremIpsum.vim	ダミーテキスト
lunatic-insert.vim	insertmodeでのお遊び機能
map.vim	基本的なmapping
moveme.ascii.txt	moveme起動中のAsciiArt
moveme.vim	VimのAppWindowを移動・サイズ変更
netrw.conf.vim	Netrwの追加設定
quickfixdo.vim	argdoみたいな感じでquickfixも
rolling-color.vim	colorschemeが順番に(お遊び)
runsoon.vim	buffer上のテキストをscriptとして実行
suiSyntax.vim	syntax拡張(after/syntax移行予定)
twin-prime.vim	双子素数(お遊び)
visualization.vim	全角スペースの可視化など
visualsearch.vim	visualmodeからの検索を機能拡張
intro-schedule.vim	intro画面にscheduleを表示
motion.vim	motionに関わるmapping(map.vimと統合)
fightline.vim	格闘ゲーム on vim
typeline.vim	タイピング
recordjourney.vim	冒険の書を記録しますか?
rozeonline.vim	入力補助? ……邪魔


" vim: set ts=38 sts=38 sw=38 noet :
