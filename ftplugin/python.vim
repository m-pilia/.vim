" For Python comment indentation
setlocal cindent

" Insert breakpoint
nnoremap <buffer> <leader>b oimport pdb; pdb.set_trace() # XXX BREAKPOINT<esc>
