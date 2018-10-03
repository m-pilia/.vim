if exists("g:loaded_hexmode") || &cp
  finish
endif
let g:loaded_hexmode= 0.1 " version number 
let s:keepcpo = &cpo
set cpo&vim

" mappings
command -bar Hexmode call hexmode#ToggleHex()
nnoremap <C-h> :Hexmode<CR>
vnoremap <C-h> :<C-U>Hexmode<CR>

let &cpo= s:keepcpo
unlet s:keepcpo
