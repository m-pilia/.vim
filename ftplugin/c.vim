let g:load_doxygen_syntax = 1

setlocal syntax=c.doxygen

" Yank file name as header
nnoremap <silent> <leader>ch :call aux#yank_header()<cr>

" Switch between source and header
nnoremap <silent> <leader>h :CocCommand clangd.switchSourceHeader<cr>
