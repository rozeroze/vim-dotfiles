""" File: vimvc/model.vim
""" Author: rozeroze <rosettastone1886@gmail.com>
""" Version: 2018-10-12
""" Description: VimでわかるMVC

let s:TITLE    = 'VIMVC'
let s:PRESENCE = 'rozeroze'

function! vimvc#model#layout( model )
   let view = []
   let CR = { -> extend( view, [''] ) }
   call extend( view, [
            \   printf( '  -- %s --  ' . repeat( ' ', 40 ) . '[action:search]',
            \           s:TITLE )
            \ ] )
   if has_key( a:model, 'pankuzu' )
      call extend( view, [ 'pankuzu ' . join(
               \   map( deepcopy( a:model.pankuzu ), '"[link:" . v:val . "]"' ),
               \   ' > ' ) ]
               \ )
   endif
   call CR()
   if has_key( a:model, 'partial' )
      if type( a:model.partial ) == v:t_list
         call extend( view, a:model.partial )
      else
         try
            call extend( view, {'vimvc#view#' . a:model.partial}() )
         catch /.*/
            call extend( view, vimvc#view#404() )
         endtry
      endif
      call CR()
   endif
   if has_key( a:model, 'prev' )
      call extend( view, [ printf( 'prev [link:%s]', a:model.prev ) ] )
   endif
   if has_key( a:model, 'next' )
      call extend( view, [ printf( 'next [link:%s]', a:model.next ) ] )
   endif
   if has_key( a:model, 'prev' ) || has_key( a:model, 'next' )
      call CR()
   endif
   call extend( view, [ printf( 'presented by %s', s:PRESENCE ) ] )
   return view
endfunction

function! vimvc#model#search(text)
   let result = [
              \   'this is search-result page',
              \   printf('search-keyword is "%s"', a:text),
              \   '',
              \   'match-page is...'
              \ ]
   let matches = []
   if match( vimvc#view#index(), a:text ) != -1
      call extend( matches, [ 'index [link:index]' ] )
   endif
   if match( vimvc#view#list(), a:text ) != -1
      call extend( matches, [ 'list [link:list]' ] )
   endif
   if match( vimvc#view#mvc(), a:text ) != -1
      call extend( matches, [ 'mvc [link:mvc]' ] )
   endif
   if match( vimvc#view#usage(), a:text ) != -1
      call extend( matches, [ 'usage [link:usage]' ] )
   endif
   if match( vimvc#view#clientserver(), a:text ) != -1
      call extend( matches, [ 'clientserver [link:clientserver]' ] )
   endif
   if match( vimvc#view#package(), a:text ) != -1
      call extend( matches, [ 'package [link:package]' ] )
   endif
   if len( matches ) == 0
      call extend( result, [ 'Not Matche' ] )
   else
      call extend( result, [ '' ] )
      call extend( result, matches )
   endif
   return result
endfunction




" vim: set ts=3 sts=3 sw=3 et :
