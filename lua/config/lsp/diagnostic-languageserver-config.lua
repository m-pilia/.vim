return {
    init_options = {
        linters = {
            bandit = {
                command = 'bandit',
                args = {
                    '--format',
                    'custom',
                    '--msg-template', '{line}:{severity}:{msg} ({test_id})',
                    '%file'
                },
                sourceName = 'bandit',
                formatPattern = {
                    '(\\d+):(.+):(.*)',
                    {
                        line = 1,
                        security = 2,
                        message = 3,
                    },
                },
                securities = {
                    LOW = 'info',
                    MEDIUM = 'warning',
                    HIGH = 'error',
                },
            },

            bibclean = {
                command = 'bibclean',
                args = {'-file-position', '%file'},
                sourceName = 'bibclean',
                isStdin = false,
                isStderr = true,
                formatPattern = {
                    '^(%%|\\?\\?)\\s*.*[:,](?:\\s*line\\s*)?(\\d+):\\s*(.*)$',
                    {
                        security = 1,
                        line = 2,
                        message = 3,
                    },
                },
                securities = {
                    ['%%'] = 'warning',
                    ['??'] = 'error',
                },
            },

            checkmake = {
                command = 'checkmake',
                args = {'%file', '--format', 'W:{{.LineNumber}}:{{.Violation}} ({{.Rule}})'},
                sourceName = 'checkmake',
                formatPattern = {
                    '(.+):(\\d+):(.+)',
                    {
                        security = 1,
                        line = 2,
                        message = 3,
                    },
                },
                securities = {
                    W = 'warning',
                },
            },

            chktex = {
                command = 'chktex',
                args = {'-v0', '-p', 'stdin', '-q', '-I'},
                sourceName = 'chktex',
                formatPattern = {
                    '^(stdin):(\\d+):(\\d+):(\\d+):(.+)$',
                    {
                        security = 1,
                        line = 2,
                        column = 3,
                        message = {'(', 4, ') ', 5},
                    },
                },
                securities = {
                    stdin = 'warning',
                },
            },

            cmakelint = {
                command = 'cmakelint',
                args = {'%file'},
                sourceName = 'cmakelint',
                formatPattern = {
                    '^.*(:)(\\d+):\\s*(.*)$',
                    {
                        security = 1,
                        line = 2,
                        message = 3,
                    },
                },
                securities = {
                    [':'] = 'warning',
                },
            },

            flake8 = {
                command = 'flake8',
                args = {'-'},
                sourceName = 'flake8',
                formatPattern = {
                    '^.+(:)(\\d+):(\\d+):\\s*(.*)$',
                    {
                        security = 1,
                        line = 2,
                        column = 3,
                        message = 4,
                    },
                },
                securities = {
                    [':'] = 'warning',
                },
            },

            gawk = {
                command = 'awk',
                args = {
                    '--source',
                    'BEGIN { exit } END { exit 1 }',
                    '-f',
                    '%file',
                    '--lint',
                    '/dev/null',
                },
                sourceName = 'gawk',
                isStderr = true,
                formatPattern = {
                    '^.*:(\\d+):\\s*(warning:|\\^)\\s*(.*)',
                    {
                        line = 1,
                        security = 2,
                        message = 3,
                    },
                },
                securities = {
                    varning = 'warning',
                    warning = 'warning',
                    [''] = 'error',
                },
            },

            ['gcc-ada'] = {
                command = 'gcc',
                args = {'-x', 'ada', '-c', '-gnatc', '%file'},
                sourceName = 'gcc',
                isStderr = true,
                formatPattern = {
                    '^.+:(\\d+):(\\d+):\\s+(warning:)?\\s*(.+)\\s*$',
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4,
                    },
                },
                securities = {
                    warning = 'warning',
                    error = 'error',
                },
            },

            gitlint = {
                command = 'gitlint',
                args = {
                    '--config', vim.fn.expand('~/.config/gitlint'),
                    '--msg-filename', '%file',
                    'lint',
                },
                sourceName = 'gitlint',
                isStderr = true,
                formatPattern = {
                    '^(\\d+):\\s*(.*)$',
                    {
                        line = 1,
                        message = 2,
                    },
                },
            },

            hadolint = {
                command = 'hadolint',
                args = {'--no-color', '-'},
                sourceName = 'hadolint',
                formatPattern = {
                    '^.*:(\\d+):?(\\d+)?\\s*(DL|SC|\\^)?(\\d+)?\\s*(.*)$',
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = {'hadolint: ', 5, ' (', 3, 4, ')'},
                    },
                },
                securities = {
                    DL = 'warning',
                    SC = 'warning',
                    [''] = 'error',
                },
            },

            ispc = {
                command = 'ispc',
                args = {'--nowrap', '%file'},
                sourceName = 'ispc',
                isStderr = true,
                formatPattern = {
                    '^.+:(\\d+):(\\d+):\\s*([^:]+):\\s*(.+)$',
                    {
                        line = 1,
                        column = 2,
                        security = 3,
                        message = 4,
                    },
                },
                securities = {
                    error = 'error',
                    Error = 'error',
                    ['fatal error'] = 'error',
                    Warning = 'warning',
                    ['Performance Warning'] = 'warning',
                },
            },

            languagetool = {
                command = 'languagetool',
                debounce = 200,
                args = {'--autoDetect', '%file'},
                sourceName = 'languagetool',
                formatLines = 2,
                formatPattern = {
                    '^\\d+?\\.\\)\\s+Line\\s+(\\d+),\\s+column\\s+(\\d+),\\s+([^\\n]+)\\nMessage:\\s+(.*)$',
                    {
                        line = 1,
                        column = 2,
                        message = {4, 3},
                    },
                },
                securities = {
                    L = 'warning',
                },
            },

            mlint = {
                command = 'mlint',
                args = {'-id', '%file'},
                sourceName = 'mlint',
                isStderr = true,
                formatPattern = {
                    '^(L) (\\d+) \\(C ([0-9-]+)\\):\\s*(.+)$',
                    {
                        security = 1,
                        line = 2,
                        column = 3,
                        message = 4,
                    },
                },
                securities = {
                    L = 'warning',
                },
            },

            qmllint = {
                command = 'qmllint',
                args = {'%file'},
                sourceName = 'qmllint',
                isStderr = true,
                formatPattern = {
                    '.*:(\\d+)\\s*:\\s*(.+)',
                    {
                        line = 1,
                        message = 2,
                    },
                },
            },

            shellcheck = {
                command = 'shellcheck',
                args = {'-x', '--format=gcc', '-'},
                sourceName = 'shellcheck',
                formatPattern = {
                    '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
                    {
                        line = 1,
                        column = 2,
                        message = 4,
                        security = 3,
                    },
                },
                securities = {
                    error = 'error',
                    warning = 'warning',
                    note = 'info',
                },
            },

            shellcheck_pkgbuild = vim.fn['pkgbuild#diagnostic_languageserver'](),

            vint = {
                command = 'vint',
                args = {'--style-problem', '%file'},
                sourceName = 'vint',
                formatPattern = {
                    '[^:]+:(\\d+):(\\d+):\\s*(.*)$',
                    {
                        line = 1,
                        column = 2,
                        message = 3,
                    },
                },
            },

        },

        filetypes = {
            ada = {'gcc-ada'},
            awk = {'gawk'},
            bib = {'bibclean'},
            cmake = {'cmakelint'},
            dockerfile = {'hadolint'},
            gitcommit = {'gitlint'},
            ispc = {'ispc'},
            make = {'checkmake'},
            matlab = {'mlint'},
            pkgbuild = {'shellcheck_pkgbuild'},
            qml = {'qmllint'},
            tex = {'chktex'},
            vim = {'vint'},
        },
    },
}
