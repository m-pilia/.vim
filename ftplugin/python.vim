" For Python comment indentation
setlocal cindent

" Insert breakpoint
nnoremap <buffer> <leader>b ofrom pprint import pprint; import pdb; pdb.set_trace()  # XXX BREAKPOINT<esc>
