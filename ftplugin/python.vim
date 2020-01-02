" For Python comment indentation
setlocal cindent

" Insert breakpoint
nnoremap <buffer> <leader>b ofrom pprint import pprint; import pdb; pdb.set_trace()  # XXX BREAKPOINT<esc>

" Load stack trace from clipboard to quickfix window
nnoremap <buffer> <F10> :call aux#python_stack_trace_to_quickfix()<cr>
