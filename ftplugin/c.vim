setlocal syntax=c.doxygen

" Yank file name as header
nnoremap <silent> <leader>ch :call aux#yank_header()<cr>
