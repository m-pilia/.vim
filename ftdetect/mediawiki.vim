" vint: -ProhibitAutocmdWithNoGroup

autocmd BufRead,BufNewFile *.itwiki
\   set filetype=mediawiki |
\   let b:vim_mediawiki_site = 'it.wikipedia.org' |
\   set spelllang=it

autocmd BufRead,BufNewFile *.enwiki
\   set filetype=mediawiki |
\   let b:vim_mediawiki_site = 'en.wikipedia.org' |
\   set spelllang=en

