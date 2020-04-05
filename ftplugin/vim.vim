" Do not indent line continuations
let g:vim_indent_cont=0

" Fold method
setlocal foldmethod=marker

" Show help for the word under cursor
nnoremap <silent> <buffer> K :help <c-r>=aux#vimhelp()<cr><cr>
