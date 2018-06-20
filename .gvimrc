set encoding=utf-8
scriptencoding utf-8

""" colorscheme
if has('gui_running')
   " https://github.com/rozeroze/vim-colorschemes/blob/master/colors/frozendaiquiri.vim
   colorscheme frozendaiquiri
else
   colorscheme desert
endif

""" フォント
set guifont=あんずもじ等幅:h12:cSHIFTJIS:qDRAFT

""" list
set list
"set listchars=eol:┸,tab:[_,trail:~,extends:>,precedes:<
set listchars=eol:^,tab:[_,trail:~,extends:>,precedes:<

""" GUI オプション
set guioptions=

""" Vim ウィンドウサイズ
set lines=24
set columns=80

""" ruler statuslineの右にあるあれ << 12,34-56 78% >>
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" reset when gui start
set t_vb=

" intro gvimrc でないと効かないらしい
set shortmess+=I

set mouse=n

""" invisible
autocmd GUIEnter * set transparency=245


" vim: set ts=3 sts=3 sw=3 et :
