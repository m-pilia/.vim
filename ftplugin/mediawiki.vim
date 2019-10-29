" Enable spell
setlocal spell

nnoremap <buffer> _ g0

vmap <silent> <buffer> i' <plug>(mediawiki-text-object-inside-tick)
vmap <silent> <buffer> a' <plug>(mediawiki-text-object-around-tick)
omap <silent> <buffer> i' <plug>(mediawiki-text-object-inside-tick)
omap <silent> <buffer> a' <plug>(mediawiki-text-object-around-tick)

vmap <silent> <buffer> ih <plug>(mediawiki-text-object-inside-heading)
vmap <silent> <buffer> ah <plug>(mediawiki-text-object-around-heading)
omap <silent> <buffer> ih <plug>(mediawiki-text-object-inside-heading)
omap <silent> <buffer> ah <plug>(mediawiki-text-object-around-heading)

nnoremap <silent> <buffer> <leader>p :MediaWikiPreview<cr>
