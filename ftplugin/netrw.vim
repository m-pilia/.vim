nnoremap <buffer> <silent> q :bd<cr>
nnoremap <buffer> <silent> ~ :Explore ~/<cr>
nnoremap <buffer> <silent> . : <c-r>=aux#netrw_path()<cr><home>
nnoremap <buffer> <silent> y :call setreg(v:register, aux#netrw_path())<cr>
