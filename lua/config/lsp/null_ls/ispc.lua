local null_ls = require('null-ls')
local helpers = require('null-ls.helpers')

return {
    name = 'ispc',
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = {'ispc'},
    generator = null_ls.generator({
        command = 'ispc',
        args = {
            '--nowrap',
            '$FILENAME',
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
                pattern = [[^.+:(%d+):(%d+):%s*([^:]+):%s*(.+)$]],
                groups = {'row', 'col', 'severity', 'message'},
                overrides = {
                    severities = {
                        ["error"] = 1,
                        ["Error"] = 1,
                        ["fatal error"] = 1,
                        ["Warning"] = 2,
                        ["Performance Warning"] = 2,
                    },
                },
            },
        }),
    }),
}

