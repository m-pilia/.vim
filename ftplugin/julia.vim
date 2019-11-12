let g:latex_to_unicode_tab = v:false

" Convert LaTeX to Unicode
imap <buffer> <silent> <expr> <Tab> !aux#is_latex(getline('.'), col('.')) ? "\<Plug>(smart_tab)" : "\<Plug>(latex2unicode)"
inoremap <buffer> <silent> <Plug>(latex2unicode) <C-O>:let save_ve = &virtualedit<cr>
    \<C-o>:set virtualedit=all<cr>
    \<C-o>:call aux#latex2unicode(getline('.'), col('.'))<cr>
    \<C-o>:let &virtualedit = save_ve<cr>
    \<Esc>a
cnoremap <buffer> <Tab> <C-\>eaux#latex2unicode_cmd()<cr>
