""" File: vimvc/controller.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

function! vimvc#controller#404()
   call vimvc#server#log(printf('vimvc#controller#404() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', '404']
   let model.partial = vimvc#view#404()
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   return string(obj)
endfunction

function! vimvc#controller#search(arg)
   call vimvc#server#log(printf('vimvc#controller#search("%s") %s', a:arg, strftime('%c')))
   let model = {}
   let model.pankuzu = ['index']
   let model.partial = vimvc#model#search(a:arg)
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   return string(obj)
endfunction

function! vimvc#controller#index()
   call vimvc#server#log(printf('vimvc#controller#index() %s', strftime('%c')))
   let model = {}
   let model.partial = vimvc#view#index()
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#index()
   return string(obj)
endfunction

function! vimvc#controller#list()
   call vimvc#server#log(printf('vimvc#controller#list() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', 'list']
   let model.partial = vimvc#view#list()
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#list()
   return string(obj)
endfunction

function! vimvc#controller#mvc()
   call vimvc#server#log(printf('vimvc#controller#mvc() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', 'list', 'mvc']
   let model.partial = vimvc#view#mvc()
   let model.next = 'usage'
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#mvc()
   return string(obj)
endfunction

function! vimvc#controller#usage()
   call vimvc#server#log(printf('vimvc#controller#usage() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', 'list', 'usage']
   let model.partial = vimvc#view#usage()
   let model.prev = 'mvc'
   let model.next = 'clientserver'
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#usage()
   return string(obj)
endfunction

function! vimvc#controller#clientserver()
   call vimvc#server#log(printf('vimvc#controller#clientserver() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', 'list', 'clientserver']
   let model.partial = vimvc#view#clientserver()
   let model.prev = 'usage'
   let model.next = 'package'
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#package()
   return string(obj)
endfunction

function! vimvc#controller#package()
   call vimvc#server#log(printf('vimvc#controller#package() %s', strftime('%c')))
   let model = {}
   let model.pankuzu = ['index', 'list', 'package']
   let model.partial = vimvc#view#package()
   let model.prev = 'clientserver'
   let obj = {}
   let obj.text = vimvc#model#layout(model)
   let obj.script = vimvc#script#package()
   return string(obj)
endfunction

" vim: set ts=3 sts=3 sw=3 et :
