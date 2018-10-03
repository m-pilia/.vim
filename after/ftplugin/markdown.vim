" display the rendered markdown in your browser
if executable('grip')
    nnoremap <buffer><space>m :Dispatch! grip -b %<cr>
endif
