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
 -> settingsという名前もどうかと思うので、そのうち変更する
 -> rozerc に変更 2019-03-26


# Rule of CharSet
encoding: utf-8 nobomb
fileformat: unix <LF>


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
Author(Maintainer)に rozeroze <rosettastone1886@gmail.com> を記載
Versionは日付とし、1.0.0のようなVersion管理方式は使わない
VersionとDescriptionの間に空行が入ってもいい
例)
""" File: scarborough.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-08-07
""" Description: Are you going to Scarborough Fair?


# Variables
global空間を汚染しすぎないようにする
let g:rzrz = {}
をsource settings/*する前に定義する
ex: testに設定値を渡すなら、下記の通りに
let g:rzrz.test = { 設定値 }
->そもそも変数は渡さないようにする
  必要な情報があればscriptに直書きする
  * settingはもともと1ファイルで完結する程度のscript用です故
-> g:rozerc['test'] = 設定値 " rozercを使用するよう変更 2019-03-26


# TODO
・passwordなどの非公開情報のみ渡すようにし、他はHARD-CODING
  -> passwordなどの情報が必要になるなら、packageに作る
・settings下のscriptは、環境ごとの設定（環境変数を直書き予定）
・rule-of-errorのerrorとfailについて、いい加減に使い分けているのを正す
・各script毎のTODOなどをどう管理するか考える
  scriptファイルに直接書き込み、foldで折りたたむなど言語道断
・いい加減 README.txt を README.md にrenameしておく
・loaded_scriptが存在するかでロードするか判定しているが、邪魔
 -> Setsコマンドを作成し、:Sets <name> で該当のscriptをロードする
 -> それが package/setset だったが、開発が止まっている
 -> もうそれいらん、こうする→ :source $HOME/.vim/settings/transfer.vim
 -> こうなった :Rozerc 'transfer'


# ファイル詳細 2019-03-25
chess.vim	chessができる
chessboard.vim	chessboardのみ、棋譜ならべとか
goat.vim	go to file, be package!
linkage.vim	外部Appを叩く
loremIpsum.vim	ダミーテキスト
map.vim	基本的なmapping
netrw.conf.vim	Netrwの追加設定
quickfixdo.vim	argdoみたいな感じでquickfixも
runsoon.vim	buffer上のテキストをscriptとして実行
suiSyntax.vim	syntax拡張(after/syntax移行予定)
visualization.vim	全角スペースの可視化など
visualsearch.vim	visualmodeからの検索を機能拡張
fightline.vim	格闘ゲーム on vim
typeline.vim	タイピング
recordjourney.vim	冒険の書を記録しますか?
mandragora.vim	よくわかる薬草学
locker.vim	Vim Locked With Password
laguillotine.vim	ラ・ギロティーヌ
lazystep.vim	何処より来りて何処へ往かん
memorystamp.vim	別ディレクトリに放り込め Like SaveAs
confusion.vim	you have some-damage! you confused!
crunch.vim	read crunches
task.vim	task list
life.vim	LIFE -- 生命 --
binedit.vim	binary file editable
chilimarker.vim	Column HIghLIght MARKER
float.vim	Make Vim-Screen Float
visualplus.vim	improve visual-mode
completion.vim	M & A: completechar & input


" vim: set ts=38 sts=38 sw=38 noet :
