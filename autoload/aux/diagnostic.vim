" Return linter settings for diagnostic-languageserver
function! aux#diagnostic#linters() abort
    return {
    \   'bandit': {
    \       'command': 'bandit',
    \       'args': [
    \           '--format',
    \           'custom',
    \           '--msg-template', '{line}:{severity}:{msg} ({test_id})',
    \           '%file'
    \       ],
    \       'sourceName': 'bandit',
    \       'formatPattern': [
    \           '(\d+):(.+):(.*)',
    \           {
    \               'line': 1,
    \               'security': 2,
    \               'message': 3,
    \           },
    \       ],
    \       'securities': {
    \           'LOW': 'info',
    \           'MEDIUM': 'warning',
    \           'HIGH': 'error',
    \       },
    \   },
    \   'bibclean': {
    \       'command': 'bibclean',
    \       'args': ['-file-position', '%file'],
    \       'sourceName': 'bibclean',
    \       'isStdin': v:false,
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^(%%|\?\?)\s*.*[:,](?:\s*line\s*)?(\d+):\s*(.*)$',
    \           {
    \               'security': 1,
    \               'line': 2,
    \               'message': 3,
    \           },
    \       ],
    \       'securities': {
    \           '%%': 'warning',
    \           '??': 'error',
    \       },
    \   },
    \   'checkmake': {
    \       'command': 'checkmake',
    \       'args': ['%file', '--format', 'W:{{.LineNumber}}:{{.Violation}} ({{.Rule}})'],
    \       'sourceName': 'checkmake',
    \       'formatPattern': [
    \           '(.+):(\d+):(.+)',
    \           {
    \               'security': 1,
    \               'line': 2,
    \               'message': 3,
    \           },
    \       ],
    \       'securities': {
    \           'W': 'warning',
    \       },
    \   },
    \   'chktex': {
    \       'command': 'chktex',
    \       'args': ['-v0', '-p', 'stdin', '-q', '-I'],
    \       'sourceName': 'chktex',
    \       'formatPattern': [
    \           '^(stdin):(\d+):(\d+):(\d+):(.+)$',
    \           {
    \               'security': 1,
    \               'line': 2,
    \               'column': 3,
    \               'message': ['(', 4, ') ', 5],
    \           },
    \       ],
    \       'securities': {
    \           'stdin': 'warning',
    \       },
    \   },
    \   'cmakelint': {
    \       'command': 'cmakelint',
    \       'args': ['%file'],
    \       'sourceName': 'cmakelint',
    \       'formatPattern': [
    \           '^.*(:)(\d+):\s*(.*)$',
    \           {
    \               'security': 1,
    \               'line': 2,
    \               'message': 3,
    \           },
    \       ],
    \       'securities': {
    \           ':': 'warning',
    \       },
    \   },
    \   'gawk': {
    \       'command': 'awk',
    \       'args': [
    \           '--source',
    \           'BEGIN { exit } END { exit 1 }',
    \           '-f',
    \           '%file',
    \           '--lint',
    \           '/dev/null',
    \       ],
    \       'sourceName': 'gawk',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^.*:(\d+):\s*(warning:|\^)\s*(.*)',
    \           {
    \               'line': 1,
    \               'security': 2,
    \               'message': 3,
    \           },
    \       ],
    \       'securities': {
    \           'varning:': 'warning',
    \           'warning:': 'warning',
    \           '': 'error',
    \       },
    \   },
    \   'gcc-ada': {
    \       'command': 'gcc',
    \       'args': ['-x', 'ada', '-c', '-gnatc', '%file'],
    \       'sourceName': 'gcc',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^.+:(\d+):(\d+):\s+(warning:)?\s*(.+)\s*$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'security': 3,
    \               'message': 4,
    \           },
    \       ],
    \       'securities': {
    \           'warning': 'warning',
    \           'error': 'error',
    \       },
    \   },
    \   'gitlint': {
    \       'command': 'gitlint',
    \       'args': [
    \           '--config', expand('~/.config/gitlint'),
    \           '--msg-filename', '%file',
    \           'lint',
    \       ],
    \       'sourceName': 'gitlint',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^(\d+):\s*(.*)$',
    \           {
    \               'line': 1,
    \               'message': 2,
    \           },
    \       ],
    \   },
    \   'hadolint': {
    \       'command': 'hadolint',
    \       'args': ['-'],
    \       'sourceName': 'hadolint',
    \       'formatPattern': [
    \           '^.*:(\d+):?(\d+)?\s*(DL|SC|\^)?(?:\d+)?\s*(.*)$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'security': 3,
    \               'message': 4,
    \           },
    \       ],
    \       'securities': {
    \           'DL': 'warning',
    \           'SC': 'warning',
    \           '': 'error',
    \       },
    \   },
    \   'ispc': {
    \       'command': 'ispc',
    \       'args': ['--nowrap', '%file'],
    \       'sourceName': 'ispc',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^.+:(\d+):(\d+):\s*([^:]+):\s*(.+)$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'security': 3,
    \               'message': 4,
    \           },
    \       ],
    \       'securities': {
    \           'error': 'error',
    \           'Error': 'error',
    \           'fatal error': 'error',
    \           'Warning': 'warning',
    \           'Performance Warning': 'warning',
    \       },
    \   },
    \   'languagetool': {
    \       'command': 'languagetool',
    \       'debounce': 200,
    \       'args': ['--autoDetect', '%file'],
    \       'sourceName': 'languagetool',
    \       'formatLines': 2,
    \       'formatPattern': [
    \           '^\d+?\.\)\s+Line\s+(\d+),\s+column\s+(\d+),\s+([^\n]+)\nMessage:\s+(.*)$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'message': [4, 3],
    \           },
    \       ],
    \       'securities': {
    \           'L': 'warning',
    \       },
    \   },
    \   'mlint': {
    \       'command': 'mlint',
    \       'args': ['-id', '%file'],
    \       'sourceName': 'mlint',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '^(L) (\d+) \(C ([0-9-]+)\):\s*(.+)$',
    \           {
    \               'security': 1,
    \               'line': 2,
    \               'column': 3,
    \               'message': 4,
    \           },
    \       ],
    \       'securities': {
    \           'L': 'warning',
    \       },
    \   },
    \   'qmllint': {
    \       'command': 'qmllint',
    \       'args': ['%file'],
    \       'sourceName': 'qmllint',
    \       'isStderr': v:true,
    \       'formatPattern': [
    \           '.*:(\d+)\s*:\s*(.+)',
    \           {
    \               'line': 1,
    \               'message': 2,
    \           },
    \       ],
    \   },
    \   'shellcheck': {
    \       'command': 'shellcheck',
    \       'args': ['-x', '--format=gcc', '-'],
    \       'sourceName': 'shellcheck',
    \       'formatPattern': [
    \           '^[^:]+:(\d+):(\d+):\s+([^:]+):\s+(.*)$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'message': 4,
    \               'security': 3,
    \           },
    \       ],
    \       'securities': {
    \           'error': 'error',
    \           'warning': 'warning',
    \           'note': 'info',
    \       },
    \   },
    \   'shellcheck_pkgbuild': pkgbuild#diagnostic_languageserver(),
    \   'vint': {
    \       'command': 'vint',
    \       'args': ['--style-problem', '%file'],
    \       'sourceName': 'vint',
    \       'formatPattern': [
    \           '[^:]+:(\d+):(\d+):\s*(.*)$',
    \           {
    \               'line': 1,
    \               'column': 2,
    \               'message': 3,
    \           },
    \       ],
    \   },
    \ }
endfunction
