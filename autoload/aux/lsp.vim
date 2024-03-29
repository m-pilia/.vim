function! aux#lsp#coc_config() abort
    return {
\       'ccls': {
\           'command': 'ccls',
\           'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
\           'rootPatterns': [
\               '.ccls',
\               'compile_commands.json',
\               '.git/',
\               '.hg/',
\           ],
\           'initializationOptions': {
\               'cache': {
\                   'directory': expand('~/.cache/ccls'),
\               },
\               'highlight': {
\                   'lsRanges': v:true,
\               },
\           },
\       },
\       'clangd': {
\           'command': 'clangd',
\           'filetypes': ['cuda'],
\           'rootPatterns': [
\               'compile_flags.txt',
\               'compile_commands.json',
\               '.git/',
\               '.hg/',
\           ],
\       },
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
