local null_ls = require('null-ls')
local helpers = require('null-ls.helpers')

return {
    name = 'gawk',
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = {'awk'},
    generator = null_ls.generator({
        command = 'gawk',
        args = {
            '--source',
            'BEGIN { exit } END { exit 1 }',
            '-f',
            '$FILENAME',
            '--lint',
            '/dev/null',
        },
        from_stderr = true,
        to_temp_file = true,
        format = 'line',

        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                print(stderr)
            end
            return success
        end,

        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[^.*:(%d+):%s*(warning):%s*(.*)]],
                groups = {'row', 'severity', 'message'},
            },
            {
                pattern = [[^.*:(%d+):%s*(.*)]],
                groups = {'row', 'message'},
            },
        }),
    }),
}
