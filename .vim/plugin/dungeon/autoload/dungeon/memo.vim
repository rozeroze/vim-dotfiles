" Vim plugin script
" File: dungeon/memo.vim
" Summary: dungeon keeper on Vim
" Authors: rozeroze <rosettastone1886@gmail.com>
" License: undecided
" Version: 2018-1-1


" TODO: archetype {{{
" skeleton の量産を絞る
" wizard の特殊スキルは対象Typeごとに変化後を変える
"   今のままではモンスターばかり増えていて見分けがつかない
" harpy に魅惑のスキルを追加する（対tamer）
"   魅惑スキルを弱体化するか、一定ターン後に解除されるようにする
" lancer の攻撃時の貫通効果がおかしい　貫通対象の位置
" 攻撃時の処理を攻撃側ではなく被害側に実装する
"   gengar に hide を実装する（hide時は攻撃をうけない）
" new monster <<cost tank>> 実装
"   生きている限り cost が増加する　無移動・無攻撃
" rook の弱体化　仲間を呼ぶ特殊スキル追加
" 使役できるモンスターに上限を設ける
" turnlist にユニット以外のフィールド要素を盛り込む
" field に空きが無くなった時の対応
" wizard によって作られた fiary のマナヒーリングが死後も続いている
"   というより、主に wizard が原因のエラー多発？
" 上記の変更を　誰かに押し付ける
" }}}

" TODO: append {{{
" manaに関する関数群がkeeperにて定義されているのをfieldに移動
" unitの共通関数を抜き出す　keeperもそこから参照する
" いままで設定後放置系だったのをkeeper参加のターン制に変更　付随する変更多数
"   keeperにパラメーター追加　life, ...etc
"   keeperに関数追加 dig, bury, command, ...etc（壁を掘る、埋める、モンスターに命令）
"   keeperの既存関数を修正？
"   keeper行動に関する設定値を追加 auto, skip, wait, ...etc
"   keeperのターン以外にkeeperが行動できないようにする
" 場所無視系の移動と攻撃を制限　keeperがあっさり負けないように
" イベントによるmapの拡張と敵の出現+イベントメッセージ
"   イベントmap拡張による壁の種類の追加（壊せない壁）
" mapの密集度を計算する関数の開発　目的未定　使用予定なし？　……あるにはあるけど
" autoloadはファイルを分けると処理が重くなるらしいので、このファイルにまとめる
"   funcitonが多くなってしまうので、辞書関数にしてアクセスしやすいようにする
" }}}

" MEMO: second dungeon 今は不要 {{{
" make()に可変引数をとれるように変更　2つ目のダンジョン出現があるかも
"   2度目以降のmake()ではtabを作らないように変更する
"   mapを自由に設定できるように変更する
" }}}


" vim: set ts=3 sts=3 sw=3 et :
