set formatoptions+=t
set formatoptions-=l

" Text width
setlocal textwidth=79

" Enable spell
setlocal spell

let b:AutoPairs = g:AutoPairs
let s:markdown_pairs = {
\   '{%': '%}',
\}
call extend(b:AutoPairs, s:markdown_pairs)
