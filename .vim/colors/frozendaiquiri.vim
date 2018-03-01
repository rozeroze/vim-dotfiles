set background=dark

hi clear

if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "frozendaiquiri"

" Specific colors
hi CursorLine                  guibg=#2d2d2d
hi ColorColumn                 guibg=#2d2d2d
hi CursorColumn                guibg=#2d2d2d
hi MatchParen    guifg=#d0ffc0 guibg=#2f2f2f gui=bold
hi Pmenu         guifg=#f0f088 guibg=#444444
hi PmenuSel      guifg=#f0f0a0 guibg=#666688 gui=bold

" General colors
hi Cursor       guifg=NONE    guibg=#626262 gui=none
hi Normal       guifg=#adc7dc guibg=#202020 gui=none
hi NonText      guifg=#808080 guibg=#202020 gui=none
hi LineNr       guifg=#808080 guibg=#202020 gui=none
hi StatusLine   guifg=#ddddee guibg=#404060 gui=bold
hi StatusLineNC guifg=#9999aa guibg=#404060 gui=none
hi TabLine      guifg=#7777aa guibg=#202020 gui=underline
hi TabLineFill  guifg=#202020 guibg=#202020 gui=underline
hi TabLineSel   guifg=#9999ff guibg=#202020 gui=underline,bold
hi VertSplit    guifg=#444444 guibg=#444444 gui=none
hi Folded       guifg=#a0a8b0 guibg=#202020 gui=none
hi Title        guifg=#b6cbf2 guibg=NONE    gui=bold
hi Visual       guifg=#e4e6ff guibg=#3a3c41 gui=none
hi SpecialKey   guifg=#404040 guibg=#202020 gui=none
hi CursorLineNr guifg=NONE

" Syntax highlighting
hi Comment    guifg=#808080 gui=none
hi Boolean    guifg=#7fb2e5 gui=bold
hi String     guifg=#7aa6c7 gui=bold
hi Identifier guifg=#7fb2e5 gui=none
hi Function   guifg=#5a90b9 gui=bold
hi Type       guifg=#7e8aa2 gui=none
hi Statement  guifg=#7e8aa2 gui=none
hi Keyword    guifg=#7b9c9c gui=none
hi Constant   guifg=#7b9c9c gui=none
hi Number     guifg=#3ea0ea gui=none
hi Special    guifg=#5b8484 gui=none
hi PreProc    guifg=#d8ceff gui=bold
hi Error      guifg=#ff8080 guibg=#a06060 gui=bold
hi Todo       guifg=#80a0ff guibg=#606060 gui=bold
hi Search     guifg=#f0f0f0 guibg=#404080

" Diff colors
hi DiffAdd    guifg=#e0e0e0 guibg=#660000
hi DiffChange guifg=#e0e0e0 guibg=#666600
hi DiffDelete guifg=#e0e0e0 guibg=#000066
hi DiffText   guifg=#dddd88 guibg=#444444

" Conceal
hi! link Conceal Nontext

