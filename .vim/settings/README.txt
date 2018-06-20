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


# Rule of CharSet
scriptファイルはutf-8
BOMの有無は保留、とりあえず現状の有無を調査してから
# Rule of Name
scriptファイルの命名規則
・許される文字は[a-zA-Z0-9]と記号_(underscore)のみ
・基本的に[a-z]のみで命名するのが望ましい
命名の良し悪しの参考に
  goat.vim	名前から機能がわかる必要はなく、
	素晴らしい名前
  abbreviate.vim	普通によい名前
  bufferlist.vim	複数単語をそのままつなげても
	意味がわかり、よい名前
  test_something.vim	可、あまりよくないが、許される名前
  intro-schedule.vim	-(ハイフン)があり、よくない名前
  loremIpsum.vim	大文字が含まれており、よくない名前
# Rule of Error
error-messageの規則について
特に規則を設けたつもりはないが、いつの間にか定着していたので、下記に準する
・error/failのどちらなのかを明示する
・メッセージは簡潔、文字数（小）に
・どのscriptfileで発生したかを明示する
message例) test.vimにてerror/failが発生した場合
  error: argument's type was wrong. -test.vim
  fail: command was disabled. -test.vim
script例) test.vimにてerrorが発生した場合
  echo 'error: ' . name . ' was not found. -test.vim'
  echo printf('error: %s was not found. -test.vim', name)


# Headers
各scriptファイルのヘッダ部分にファイル情報を記載する
例)
""" Theme: 
""" Summary: 
""" Files: filename.vim utf-8 bomb
""" Last Change: 2018-06-11
元々、各scriptの1行目にはダブルクォート3つと簡易英文があったのを廃止する
その簡易英文はThemeとして残しはする


# Variable
global空間を汚染しすぎないようにする
let g:rzrz = {}
をsource settings/*する前に定義する
ex: testに設定値を渡すなら、下記の通りに
let g:rzrz.test = { 設定値 }


# TODO
・passwordなどの非公開情報のみ渡すようにし、他はHARD-CODING
・settings下のscriptは、環境ごとの設定（環境変数を直書き予定）
・rule-of-errorのerrorとfailについて、いい加減に使い分けているのを正す
・各script毎のTODOなどをどう管理するか考える
  scriptファイルに直接書き込み、foldで折りたたむなど言語道断
・いい加減 README.txt を README.md にrenameしておく


# Git (under control)
completechar.vim
goat.vim
moveme.vim
quickfixdo.vim
recordjourney.vim
runsoon.vim
visualization.vim
visualsearch.vim
fixregister.vim


# ファイル詳細 2018-06-19
abbreviate.vim	短縮入力(after/ftplugin移行予定)
bufferlist.vim	buffer-listからVimで開く
chess.vim	chessができる
chessboard.vim	chessboardのみ、棋譜ならべとか
colorschemer.vim	colorschemeの簡易作成
colorschemer.tmp.txt	colorschemer-template
completechar.vim	特殊文字の入力補助
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
twin-prime.vim	双子素数のミレニアム
visualization.vim	全角スペースの可視化など
visualsearch.vim	visualmodeからの検索を機能拡張
intro-schedule.vim	intro画面にscheduleを表示
intro-schedule.txt	intro-scheduleのデータ部分
google_calendar_sync.py	intro-scheduleとGoogleCalendar連携
motion.vim	motionに関わるmapping(map.vimと統合)
fightline.vim	格闘ゲーム on vim
typeline.vim	タイピング
recordjourney.vim	冒険の書を記録しますか?
rozeonline.vim	入力補助? ……邪魔
mandragora.vim	よくわかる薬草学
littlehelper.vim	with a little help from my friends
locker.vim	Vim Locked With Password
laguillotine.vim	ラ・ギロティーヌ
keylogger.vim	Key Logger
dotgraph.vim	preview n edit .dot files (graphviz)
mastercancel.vim	integrated cancel stroke on vim
lazystep.vim	何処より来りて何処へ往かん
memorystamp.vim	別ディレクトリに放り込め Like SaveAs
slum.vim	windows only == slum owner
instantset.vim	mask-cmd :set aaa=bbb to :Set aaa
writeorders.vim	ご注文はWriteですか？
lastdays.vim	死の日の記憶
expandspace.vim	like 'expandtab' apple division
confusion.vim	you have some-damage! you confused!
project.vim	project box, easy starter
crunch.vim	read crunches
input.vim	複数文字の入力補助(like completechar)
fridaynight.vim	Mr.FridayNight. who was not banker.
fixregister.vim	part of registers was fixed
daychange.vim	日替わり定食(開発補助)
pathogen.vim	病原体 develop(extend) fixregister
task.vim	task list


" vim: set ts=38 sts=38 sw=38 noet :
