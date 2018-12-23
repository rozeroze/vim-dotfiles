""" File: bluescreen.vim
""" Authors: rozeroze <rosettastone1886@gmail.com>
""" License: MIT
""" Version: 2018-09-19

""" Description: blue screen of death

let s:text = [
         \ 'A problem has been detected and Windows has been shut down to prevent damage to your computer.',
         \ '',
         \ 'MEMORY_MANAGEMENT',
         \ '',
         \ 'If this is the first time youve seen this Stop error screen, restart your computer. If this screen appears again, follow these steps:',
         \ '',
         \ 'Check to make sure any new hardware or software is properly installed. If this is a new installation, ask your hardware or software manufacturer for any Windows updates you might need.',
         \ '',
         \ 'If problems continue, disable or remove any newly installed hardware or software. Disable BIOS memory options such as caching or shadowing. If you need to use Safe Mode to remove or disable components, restart your computer, press F8 to select Advanced Startup Options, and then select Safe Mode.',
         \ '',
         \ 'Technical Information:',
         \ '',
         \ '*** STOP: 0x004B3A91 (0xF39B842C, 0x00000000, 0x18E2618B, 0x00000000)',
         \ '',
         \ 'Beginning dump of physical memory',
         \ 'Physical memory dump complete.',
         \ '',
         \ 'Contact your system administrator or technical support group for further assistence.'
         \]

function! bluescreen#bluescreen()
   " MEMO: simaltがgetchar()をひとつ潰す
   simalt ~x
   call getchar()
   call bluescreen#death()
   call getchar()
   "simalt ~r
   call bluescreen#revive()
endfunction

function! bluescreen#death()
   silent tabnew bluescreen
   " global
   let b:showtabline = &showtabline
   let b:laststatus = &laststatus
   let b:ruler = &ruler
   let b:colorscheme = g:colors_name
   let b:guifont = &guifont
   let b:transparency = &transparency
   let b:guioptions = &guioptions
   set showtabline=0
   set laststatus=0
   set noruler
   set guifont=Consolas:h20:cANSI:qDRAFT
   set transparency=255
   set guioptions=C
   colorscheme bluescreen
   " local <window>
   setlocal nonumber norelativenumber
   setlocal nocursorline nocursorcolumn
   setlocal nolist
   setlocal wrap
   " local <buffer>
   setlocal buftype=nofile
   " show death
   call append(0, s:text)
   norm! ggG$
   redraw
endfunction

function! bluescreen#revive()
   let &showtabline = b:showtabline
   let &laststatus = b:laststatus
   let &ruler = b:ruler
   let &guifont = b:guifont
   let &transparency = b:transparency
   let &guioptions = b:guioptions
   execute 'colorscheme ' . b:colorscheme
   bdelete bluescreen
endfunction


" vim: set ts=3 sts=3 sw=3 et :
