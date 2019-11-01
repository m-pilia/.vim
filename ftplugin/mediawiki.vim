" Enable spell
setlocal spell

nnoremap <buffer> _ g0
vnoremap <buffer> _ g0

let b:surround_{char2nr('m')} = "<math>\r</math>"

vmap <silent> <buffer> i' <plug>(mediawiki-text-object-inside-tick)
vmap <silent> <buffer> a' <plug>(mediawiki-text-object-around-tick)
omap <silent> <buffer> i' <plug>(mediawiki-text-object-inside-tick)
omap <silent> <buffer> a' <plug>(mediawiki-text-object-around-tick)

vmap <silent> <buffer> ih <plug>(mediawiki-text-object-inside-heading)
vmap <silent> <buffer> ah <plug>(mediawiki-text-object-around-heading)
omap <silent> <buffer> ih <plug>(mediawiki-text-object-inside-heading)
omap <silent> <buffer> ah <plug>(mediawiki-text-object-around-heading)

vmap <silent> <buffer> i<bar> <plug>(mediawiki-text-object-inside-pipes)
vmap <silent> <buffer> a<bar> <plug>(mediawiki-text-object-around-pipes)
omap <silent> <buffer> i<bar> <plug>(mediawiki-text-object-inside-pipes)
omap <silent> <buffer> a<bar> <plug>(mediawiki-text-object-around-pipes)

vmap <silent> <buffer> ip <plug>(mediawiki-text-object-inside-link-page)
vmap <silent> <buffer> ap <plug>(mediawiki-text-object-around-link-page)
omap <silent> <buffer> ip <plug>(mediawiki-text-object-inside-link-page)
omap <silent> <buffer> ap <plug>(mediawiki-text-object-around-link-page)

vmap <silent> <buffer> in <plug>(mediawiki-text-object-inside-link-name)
vmap <silent> <buffer> an <plug>(mediawiki-text-object-around-link-name)
omap <silent> <buffer> in <plug>(mediawiki-text-object-inside-link-name)
omap <silent> <buffer> an <plug>(mediawiki-text-object-around-link-name)

vmap <silent> <buffer> it <plug>(mediawiki-text-object-inside-template-begin)
vmap <silent> <buffer> at <plug>(mediawiki-text-object-around-template-begin)
omap <silent> <buffer> it <plug>(mediawiki-text-object-inside-template-begin)
omap <silent> <buffer> at <plug>(mediawiki-text-object-around-template-begin)

vmap <silent> <buffer> iT <plug>(mediawiki-text-object-inside-template-end)
vmap <silent> <buffer> aT <plug>(mediawiki-text-object-around-template-end)
omap <silent> <buffer> iT <plug>(mediawiki-text-object-inside-template-end)
omap <silent> <buffer> aT <plug>(mediawiki-text-object-around-template-end)

vmap <silent> <buffer> ia <plug>(mediawiki-text-object-inside-named-argument)
vmap <silent> <buffer> aa <plug>(mediawiki-text-object-around-named-argument)
omap <silent> <buffer> ia <plug>(mediawiki-text-object-inside-named-argument)
omap <silent> <buffer> aa <plug>(mediawiki-text-object-around-named-argument)

nnoremap <silent> <buffer> <leader>p :MediaWikiPreview<cr>
