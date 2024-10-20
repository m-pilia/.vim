highlight clear

if exists('syntax_on')
    syntax reset
endif

set background=dark
let g:colors_name = 'tundra'

highlight   Comment              ctermfg=LightBlue     ctermbg=NONE         guifg=#5fd7ff   guibg=NONE
highlight   ConflictCurrent      ctermfg=Black         ctermbg=LightRed     guifg=#000000   guibg=#ffd7d7
highlight   ConflictIncoming     ctermfg=Black         ctermbg=LightGreen   guifg=#000000   guibg=#87ffaf   cterm=bold           gui=bold
highlight   ConflictParent       ctermfg=Black         ctermbg=LightBlue    guifg=#000000   guibg=#5fd7ff
highlight   Constant             ctermfg=Red           ctermbg=NONE         guifg=#ff5454   guibg=NONE
highlight   CursorLine           ctermfg=NONE          ctermbg=NONE         guifg=NONE      guibg=NONE      cterm=NONE           gui=NONE
highlight   CursorLineNr         ctermfg=Yellow        ctermbg=NONE         guifg=#ffff54   guibg=NONE      cterm=bold           gui=bold
highlight   DiffAdd              ctermfg=Black         ctermbg=Green        guifg=#000000   guibg=#54ff54   cterm=bold
highlight   DiffChange           ctermfg=Black         ctermbg=229          guifg=#000000   guibg=#ffffaf   cterm=bold
highlight   DiffDelete           ctermfg=White         ctermbg=DarkRed      guifg=#ffffff   guibg=#b21818   cterm=bold
highlight   DiffText             ctermfg=White         ctermbg=Brown        guifg=#ffffff   guibg=#b26818   cterm=bold
highlight   Directory            ctermfg=DarkCyan      ctermbg=NONE         guifg=#18b2b2   guibg=NONE
highlight   Error                ctermfg=White         ctermbg=DarkRed      guifg=#ffffff   guibg=#b21818   cterm=bold           gui=bold
highlight   ErrorMsg             ctermfg=White         ctermbg=DarkRed      guifg=#ffffff   guibg=#b21818   cterm=bold           gui=bold
highlight   FoldColumn           ctermfg=DarkGrey      ctermbg=NONE         guifg=#b2b2b2   guibg=NONE
highlight   Folded               ctermfg=DarkGrey      ctermbg=NONE         guifg=#b2b2b2   guibg=NONE
highlight   Function             ctermfg=Cyan          ctermbg=NONE         guifg=#54ffff   guibg=NONE      cterm=bold           gui=bold
highlight   GutterAdd            ctermfg=Green         ctermbg=NONE         guifg=#54ff54   guibg=NONE
highlight   GutterChange         ctermfg=Yellow        ctermbg=NONE         guifg=#ffff54   guibg=NONE
highlight   GutterChangeDelete   ctermfg=Yellow        ctermbg=NONE         guifg=#ffff54   guibg=NONE
highlight   GutterDelete         ctermfg=Red           ctermbg=NONE         guifg=#ff5454   guibg=NONE
highlight   Hint                 ctermfg=Black         ctermbg=Green        guifg=#000000   guibg=#54ff54
highlight   Identifier           ctermfg=Cyan          ctermbg=NONE         guifg=#54ffff   guibg=NONE      cterm=bold           gui=bold
highlight   Ignore               ctermfg=DarkGrey      ctermbg=NONE         guifg=#606060   guibg=NONE
highlight   IncSearch            ctermfg=DarkGrey      ctermbg=Green        guifg=#606060   guibg=#54ff54   cterm=NONE           gui=NONE
highlight   LineNr               ctermfg=Grey          ctermbg=NONE         guifg=#b8b8b8   guibg=NONE
highlight   ModeMsg              ctermfg=Brown         ctermbg=NONE         guifg=#b26818   guibg=NONE      cterm=NONE           gui=NONE
highlight   MoreMsg              ctermfg=DarkGreen     ctermbg=NONE         guifg=#18b218   guibg=NONE
highlight   Namespace            ctermfg=33            ctermbg=NONE         guifg=#0087ff   guibg=NONE
highlight   NonText              ctermfg=LightCyan     ctermbg=NONE         guifg=#afffff   guibg=NONE      cterm=bold           gui=bold
highlight   Normal               ctermfg=Grey          ctermbg=NONE         guifg=#b8b8b8   guibg=NONE
highlight   Operator             ctermfg=Brown         ctermbg=NONE         guifg=#b26818   guibg=NONE      cterm=NONE           gui=NONE
highlight   Pmenu                ctermfg=Grey          ctermbg=238          guifg=#b8b8b8   guibg=#444444
highlight   PmenuSel             ctermfg=NONE          ctermbg=DarkGrey     guifg=NONE      guibg=#6c6c6c
highlight   PreProc              ctermfg=DarkMagenta   ctermbg=NONE         guifg=#b218b2   guibg=NONE
highlight   Question             ctermfg=Green         ctermbg=NONE         guifg=#54ff54   guibg=NONE
highlight   QuickFixLine         ctermfg=NONE          ctermbg=NONE         guifg=NONE      guibg=NONE      cterm=bold           gui=bold
highlight   Search               ctermfg=223           ctermbg=172          guibg=#cd853f   guifg=#f5deb3   cterm=NONE           gui=NONE
highlight   SignColumn           ctermfg=NONE          ctermbg=NONE         guifg=NONE      guibg=NONE
highlight   Special              ctermfg=DarkMagenta   ctermbg=NONE         guifg=#b218b2   guibg=NONE
highlight   SpecialKey           ctermfg=DarkGreen     ctermbg=NONE         guifg=#18b218   guibg=NONE
highlight   SpellBad             ctermfg=White         ctermbg=DarkRed      guifg=#ffffff   guibg=#b21818   cterm=NONE           gui=NONE
highlight   SpellCap             ctermfg=White         ctermbg=Brown        guifg=#ffffff   guibg=#b26818   cterm=NONE           gui=NONE
highlight   Statement            ctermfg=Brown         ctermbg=NONE         guifg=#b26818   guibg=NONE      cterm=NONE           gui=NONE
highlight   StatusLine           ctermfg=Black         ctermbg=LightGrey    guibg=#c2bfa5   guifg=#000000   cterm=NONE           gui=NONE
highlight   StatusLineNC         ctermfg=Grey          ctermbg=LightGrey    guifg=#808080   guibg=#c2bfa5   cterm=NONE           gui=NONE
highlight   Title                ctermfg=DarkMagenta   ctermbg=NONE         guifg=#b218b2   guibg=NONE
highlight   Todo                 ctermfg=Black         ctermbg=Yellow       guifg=#000000   guibg=#ffff54
highlight   Type                 ctermfg=DarkGreen     ctermbg=NONE         guifg=#18b218   guibg=NONE      cterm=NONE           gui=NONE
highlight   Underlined           ctermfg=DarkMagenta   ctermbg=NONE         guifg=#b218b2   guibg=NONE      cterm=underline      gui=underline
highlight   VertSplit            cterm=reverse         gui=reverse
highlight   Visual               ctermfg=NONE          ctermbg=DarkGrey     guifg=NONE      guibg=#606060   cterm=reverse        gui=reverse
highlight   WarningMsg           ctermfg=DarkRed       ctermbg=NONE         guifg=#b21818   guibg=NONE
highlight   WildMenu             ctermfg=Black         ctermbg=Brown        guifg=#000000   guibg=#b26818

highlight! link Boolean Constant
highlight! link Character Constant
highlight! link Float Constant
highlight! link Number Constant
highlight! link String Constant

highlight! link Conditional Statement
highlight! link Exception Statement
highlight! link Keyword Statement
highlight! link Label Statement
highlight! link Repeat Statement

highlight! link Define PreProc
highlight! link Include PreProc
highlight! link Macro PreProc
highlight! link PreCondit PreProc

highlight! link StorageClass Type
highlight! link Structure Type
highlight! link Typedef Type

highlight! link Debug Special
highlight! link Delimiter Special
highlight! link SpecialChar Special
highlight! link SpecialComment Special
highlight! link Tag Special

