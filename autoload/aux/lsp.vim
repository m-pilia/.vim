function! aux#lsp#coc_config() abort
    return {
\       'pylsp': {
\           'command': 'pylsp',
\           'filetypes': ['python'],
\           'settings': {
\               'pylsp': {
\                   'plugins': {
\                       'pylint': {
\                           'enabled': v:false,
\                           'args': [],
\                       },
\                       'flake8': {
\                           'enabled': v:true,
\                       },
\                   },
\               },
\           },
\       },
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
