
" SORROW: 最初はただのダミーテキストのつもりだったんだ
finish

" I lost a large sum of money yesterday
function! s:WhoLostMoney() abort " {{{
   if g:who_lost_money ==? 'rozeroze'
      " SORROW: お悔やみの言葉を申し上げる
      echo 'rozeroze lost money again.'
      return g:GetDishonoredPrefix() . 'rozeroze'
   else
      return g:who_lost_money
   endif
endfunction " }}}
function! s:HowMuchLost() abort " {{{
   if type(g:how_much_lost) == v:t_number
      let _lost = g:how_much_lost
      if _lost > g:TaxIn(g:PriceOfGame('ROZEROZE-QUEST'))
         " SORROW: 悲しみの宴を開く
      endif
   endif
endfunction " }}}
function! g:SomebodyLostMoney(name, amount) abort " {{{
   let g:who_lost_money = a:name
   let g:how_much_lost = a:amount
endfunction " }}}
function! g:GetDishonoredPrefix() " {{{
   " TODO: random
   return 'foolish-'
endfunction " }}}
function! g:PriceOfGame(game) abort " {{{
   " IMPLEMENT_LATER: kick API?
   if a:game ==? 'rozeroze-quest'
      return 8000
   else
      return 6000
   endif
endfunction " }}}
function! g:TaxIn(price) " {{{
   " IMPLEMENT_LATER: 税込処理
   if localtime() > 1569855600 " 2019/10/1
      return ceil(a:price * 1.1)
   endif
   return ceil(a:price * 1.08)
endfunction " }}}
function! g:TaxOut(price) " {{{
   " IMPLEMENT_LATER: 税抜処理
   if localtime() > 1569855600 " 2019/10/1
      return ceil(a:price * 0.909091)
   endif
   return ceil(a:price * 0.925926)
endfunction " }}}


""""""""""""""""""""""""""""" lorem ipsum """"""""""""""""""""""""""""""""
" Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
" tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
" veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
" commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
" velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
" occaecat cupidatat non proident, sunt in culpa qui officia deserunt
" mollit anim id est laborum.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



