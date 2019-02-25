"{{{ neco-ghc

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
let g:haddock_browser='/usr/bin/chromium'

setlocal omnifunc=necoghc#omnifunc

"}}}

"{{{ ghc-mod

map <silent> tw :w<cr>:GhcModTypeInsert<CR>
map <silent> ts :w<cr>:GhcModSplitFunCase<CR>
map <silent> tq :w<cr>:GhcModType<CR>
map <silent> te :w<cr>:GhcModTypeClear<CR>

"}}}

"{{{ haskell-vim

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`

" haskell syntax highlight
let hs_highlight_boolean = 1
let hs_highlight_debug = 1

"}}}

"{{{ tabularize

let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

"}}}
