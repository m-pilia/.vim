let g:load_doxygen_syntax = 1

setlocal syntax=c.doxygen

" Clangd assigns a semantic token of comment to ignored code
augroup c_semantic_highlight
    autocmd BufEnter *.c,*.cpp,*.cxx,*.h,*.hpp highlight link CocSemComment Ignore
    autocmd BufLeave *.c,*.cpp,*.cxx,*.h,*.hpp highlight link CocSemComment Comment
augroup end

" Yank file name as header
nnoremap <silent> <leader>ch :call aux#yank_header()<cr>

" Switch between source and header
nnoremap <silent> <leader>h :CocCommand clangd.switchSourceHeader<cr>
