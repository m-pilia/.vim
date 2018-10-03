syntax region  juliaCommentL		matchgroup=juliaCommentDelim start="#\ze\%([^=]\|$\)" end="$" keepend contains=juliaTodo,juliaNote,@spell
syntax keyword juliaNote        contained NOTE
hi          juliaNote           ctermfg=Green
