" Jump to error from quickfix/loclist window with <cr>
nnoremap <expr> <buffer> <silent> <cr> aux#is_loclist() ? "<cr>:lclose<cr>" : "<cr>:cclose<cr>"
