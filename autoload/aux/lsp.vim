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
\       'pyls': {
\           'command': 'pyls',
\           'filetypes': ['python'],
\           'settings': {
\               'pyls': {
\                   'plugins': {
\                       'pylint': {
\                           'enabled': v:false,
\                           'args': [],
\                       },
\                   },
\               },
\           },
\       },
\       'jls': {
\           'command': 'julia',
\           'args': ['--startup-file=no', '--history-file=no', '-e', '
\               using Pkg;
\               using LanguageServer;
\               import StaticLint;
\               import SymbolServer;
\               env_path = dirname(Pkg.Types.Context().env.project_file);
\               debug = false;
\               server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path);
\               server.runlinter = true;
\               run(server);
\           '],
\           'filetypes': ['julia'],
\       },
\       'haskell': {
\           'command': 'hie-wrapper',
\           'rootPatterns': ['.stack.yaml', 'cabal.config', 'package.yaml'],
\           'filetypes': ['hs', 'lhs', 'haskell'],
\       },
\       'bash': {
\           'args': ['start'],
\           'command': 'bash-language-server',
\           'filetypes': ['sh'],
\           'ignoredRootPaths': ['~'],
\       },
\       'latex': {
\           'command': 'texlab',
\           'filetypes': ['tex', 'plaintex', 'contex'],
\       },
\       'groovy': {
\           'command': 'java',
\           'args': ['-jar', '/usr/share/java/groovy-language-server/groovy-language-server-all.jar'],
\           'filetypes': ['groovy'],
\       },
\       'r': {
\           'command': 'R',
\           'args': ['--slave', '-e', 'languageserver::run()'],
\           'filetypes': ['r'],
\       },
\       'cmake': {
\           'command': 'cmake-language-server',
\           'filetypes': ['cmake'],
\           'rootPatterns': ['build/'],
\           'initializationOptions': {
\               'buildDirectory': 'build',
\           },
\       },
\   }
endfunction
