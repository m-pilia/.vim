function! aux#lsp#coc_config() abort
    return {
\       'haskell': {
\           'command': 'hie-wrapper',
\           'rootPatterns': ['.stack.yaml', 'cabal.config', 'package.yaml'],
\           'filetypes': ['hs', 'lhs', 'haskell'],
\       },
\       'r': {
\           'command': 'R',
\           'args': ['--slave', '-e', 'languageserver::run()'],
\           'filetypes': ['r'],
\       },
\   }
endfunction
