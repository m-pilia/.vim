local null_ls = require('null-ls')
local helpers = require('null-ls.helpers')

local function make_pkgbuild_vars_patter()
    local pkgbuild_vars = {
        'pkgbase',
        'pkgname',
        'pkgver',
        'pkgrel',
        'epoch',
        'pkgdesc',
        'arch',
        'url',
        'license',
        'groups',
        'depends',
        'optdepends',
        'makedepends',
        'checkdepends',
        'provides',
        'conflicts',
        'replaces',
        'backup',
        'options',
        'install',
        'changelog',
        'source',
        'noextract',
        'validpgpkeys',
        'md5sums',
        'sha1sums',
        'sha256sums',
        'sha224sums',
        'sha384sums',
        'sha512sums',
    }
    local unassigned_vars = {
        'srcdir',
        'pkgdir',
        'startdir',
    }

    local pkgbuild_vars_pattern = table.concat(pkgbuild_vars, '|')
    local unassigned_vars_pattern = table.concat(unassigned_vars, '|')
    local unused_pattern = '(' .. pkgbuild_vars_pattern .. ') appears unused'
    local unassigned_pattern = '(' .. unassigned_vars_pattern .. ') is referenced but not assigned'

    return vim.regex('\\v(' .. unused_pattern .. '|' .. unassigned_pattern .. ')')
end

local pkgbuild_vars_pattern = make_pkgbuild_vars_patter()

local function filter_pkgbuild_diagnostics(output)
    for i = #output.comments, 1, -1 do
        local diagnostic = output.comments[i]

        if diagnostic['message'] ~= vim.NIL then
            local result = pkgbuild_vars_pattern:match_str(diagnostic.message)
            if result == 0 then
                table.remove(output.comments, i)
            end
        end
    end
end

return {
    name = 'shellcheck',
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = {'pkgbuild'},
    generator = null_ls.generator({
        command = 'shellcheck',
        args = {
            '--shell=bash',
            '--format=json1',
            '--source-path=$DIRNAME',
            '--exclude=SC2164', -- pacman runs with -e
            '-',
        },
        to_stdin = true,
        format = 'json',

        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                print(stderr)
            end
            return success
        end,

        on_output = function(params)
            local parser = helpers.diagnostics.from_json({
                attributes = {
                    code = 'code',
                },
                severities = {
                    info = helpers.diagnostics.severities['information'],
                    style = helpers.diagnostics.severities['hint'],
                },
            })

            filter_pkgbuild_diagnostics(params.output)

            return parser({output = params.output.comments})
        end,
    }),
}
