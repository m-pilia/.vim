nnoremap <buffer> <silent> q :bw<cr>
nnoremap <buffer> <silent> ~ :Explore ~/<cr>
nnoremap <buffer> <silent> . : <c-r>=aux#netrw_path()<cr><home>
nnoremap <buffer> <silent> y :call setreg(v:register, aux#netrw_path())<cr>

let s:settings = [
\   'nomodifiable',
\   'nomodified',
\   'number',
\   'nobuflisted',
\   'nowrap',
\   'readonly',
\   'norelativenumber',
\ ]

let g:netrw_bufsettings = join(s:settings, ' ')
