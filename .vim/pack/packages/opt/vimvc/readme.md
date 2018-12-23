# README

VIMVC < MVC on Vim >

### What is VIMVC

VimでわかるMVC

> VIMVCとは、ソフトウェアアーキテクチャの１つ
> MVCをVimで再現した派生パターンであり、ある程度模倣されている
> ServerはVimが担当し、ClientもVimが担当しているのが他にない特色である

### Dependence

* +clientserver
* +package
  * これ自体がpackageなのであって、必ずしも必要なわけではない

### TODO

**2018-10-12**

`vimvc#client#access()`にて`remote_expr`を実行し、エラーが発生したら404と判断し、再度`remote_expr`を実行している

`vimvc#route#routing(path)`を作成し、サーバアクセスを一括で処理するようにする

その際、routingに失敗するなら404を表示する

