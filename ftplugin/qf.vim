" Jump to error from quickfix/loclist window with <cr>
nnoremap <expr> <buffer> <silent> <cr> aux#is_loclist() ? "<cr>:lclose<cr>" : "<cr>:cclose<cr>"

" Alias to use default jump behaviour
nnoremap <c-j> <cr>
