# README

### Message Grouping

messageをなんらかの方法でグルーピングしたい
{motion} を2つ追加してみるか……

im "inner message"
   chatwork-packageでのみ使用可能な{motion}
   メッセージテキストを選択する
   ex) vim  VisualModeでMessage中身を選択

am "a message"
   chatwork-packageでのみ使用可能な{motion}
   メッセージオブジェクトを選択する
   ex) vam  VisualModeでMessage全体を選択

メッセージオブジェクトをどのように定義するか決める
draft-1)
   use 'folding'
   +---------- VIM ------------
   | rozeroze 2018-10-26 12:53 1182488439396606465 {{{
   | [To:1234567] クズ上司 さん
   | 会社辞めたいです
   | }}}
   |
   foldstart行とfoldend行を除外した中身がメッセージテキストで
   foldstartの折畳の前のテキストがメッセージ情報
   メッセージ送信者 送信日時 メッセージID があれば十分だと思う
   この状態だとメッセージテキストにfoldmarker{{{,}}}が使えないので
   (使えはするが折畳が崩れる可能性がある)
   chatwork-package用になにか考える
   foldlevelを指定すれば別にいいか……？
   +---------- VIM ------------
   | rozeroze 2018-10-26 12:53 1182488439396606465 {{{1
   | [To:1234567] クズ上司 さん
   | 会社辞めたいです
   |
   | rozeroze 2018-10-26 12:55 1182488439400930588 {{{1
   | 会社、辞めさせてください
   |

draft-2)
   メッセージ情報を変数に保持しておく
   draft-1の場合、ユーザがメッセージIDを書き換えることができ、
   その場合バッファ上のメッセージIDを元にした操作（未実装）が失敗する
   draft-2であれば、そのようなエラーの発生は抑えられる
   なお、この案が採用されることはないだろう
   テキストベースであることに強い信頼があるからだ（個人の主観であり……）

### Config File

今現在、package/chatwork/chatwork.jsonに
TokenやルームIDを保持しているが、ついさっきその情報をそのまま
Githubに上げそうになった
危ないのでrenameする

drafts)
   ~/.vim-chatwork
   ~/.vim/.chatwork
   ユーザディレクトリ直下に置くならば*vim-*というprefixをつけておいたほうが無難
   .vim/の下に置くならばprefixなどは不要だが、上記のパターンだとそれが
   json形式であることが明示的でない(読めばわかるだろうが)
   ……別によいか


- vim: fdl=20
