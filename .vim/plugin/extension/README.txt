# README

### Summary
vimscriptが用意していないデータ型などを拡張する

### Feature
- list
- queue
- stack
- random

### Usage
各scriptfileはloadしていないので、そのままでは使えない
使いたい機能のscriptfileから、先頭部分のfinish行をコメントアウトするか
あるいは、scriptcodeをyank-putして使うかのどちらか

### From now on 2018-02-23
yank-put方式を前提に開発をする予定
必要性を感じないが、hash-listとかenumみたいなのを作るかも

### From now on 2018-08-28
.vimrcに書き込み、.vim/settings/*のみで使う予定
各plugin/package内で使いたいときは、それぞれのscriptの中に
必要なものだけを書き込む(依存関係を持たないようにしたい)



