highlight clear
if exists("syntax_on")
   syntax off
endif
let g:colors_name = 'tanaka'
if &background == 'light'
   hi Normal guifg=#808080 guibg=White ctermfg=DarkGray ctermbg=White
   hi NonText guibg=White ctermbg=White
else
   hi Normal guifg=#303030 guibg=Black ctermfg=DarkGray ctermbg=Black
   hi NonText guibg=Black ctermbg=Black
   hi LineNr guifg=#505050 guibg=NONE
endif
hi CursorLine guifg=NONE guibg=NONE
hi CursorColumn guifg=NONE guibg=NONE
hi Folded guifg=NONE guibg=NONE gui=NONE
hi LineNr guifg=NONE guibg=NONE
hi CursorLineNr guifg=NONE gui=BOLD
