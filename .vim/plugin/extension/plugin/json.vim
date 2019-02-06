" Vim plugin script
" Summary: json read/write/convert
" Authors: rozeroze <rosettastone1886@gmail.com>
" Version: 2018-08-28


function! Json(...)
   let json = {}
   let json.path = ''
   let json.value = {}
   function! json.edit() dict
      execute printf('hide edit %s', self.path)
   endfunction
   function! json.save() dict
      try
         call writefile([json_encode(self.value)], self.path, '')
      catch /.*/
         echoerr 'File save failed!'
      endtry
   endfunction
   function! json.load() dict
      try
         let self.value = json_decode(join(readfile(self.path), "\n"))
      catch /.*/
         echoerr 'File load filed!'
      endtry
   endfunction
   for arg in a:000
      if type(arg) == v:t_string
         let json.path = expand(arg)
         call json.load()
      elseif type(arg) == v:t_dict
         let json.value = arg
      endif
   endfor
   return json
endfunction

finish

" USAGE:
" json.path: ファイルパス(string)
" json.value: jsonの値をVimscriptで表現したもの(dict)
" json.save(): json.valueをjson型に変更し、json.pathに保存
" json.load(): json.pathを読込、Vimscriptの型に変更しjson.valueに代入

" CASE1: 既存のjsonファイルを指定し、値を上書きする
let json = Json()
let json.path = expand('$HOME/.vim/test.json')
let json.value = { 'text': 'this is test' }
call json.save()

" CASE2: jsonファイルをVimで開く
let json = Json()
let json.path = expand('$HOME/.vim/test.json')
call json.load()
call json.edit()
" --- something change
:write " save
call json.load() " 保存されたものをvalueに取り込む

" until 2018-06-29
function! Json(arg)
   if type(a:arg) == v:t_string
      " argをpathとみなす
      let _json = <SID>json_load(a:arg)
      if _json
         " 辞書型かリスト型か知らないが、中身があればtrueになるはず
      endif
   elseif type(a:arg) == v:t_dict
   else
      " echo 'error: argument is invalid'
   endif
endfunction

function! s:json_load(path)
   if !filereadable(a:path)
      " ファイルがないか、読み込み権限がない
      return v:false
   endif
   if split(a:path, '\.')[-1] != 'json'
      " 拡張子が 'json' でない
      return v:false
   endif
   try
      " readfile()は行のlistを返す
      let _list = readfile(a:path)
      " joinによって文字列に変換
      let _text = join(_list, "\n")
      " json_decode()によって同等のVimの値に変換
      let _json = json_decode(_text)
      return _json
   catch /.*/
      " 何らかのエラー
      return v:false
   endtry
endfunction





" vim: set ts=3 sts=3 sw=3 et :
