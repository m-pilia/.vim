return {
    'nvimtools/none-ls.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
    },

    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.checkmake,
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.diagnostics.mlint,
                null_ls.builtins.diagnostics.qmllint,
                null_ls.builtins.diagnostics.vint,
                null_ls.builtins.diagnostics.zsh,
                null_ls.builtins.formatting.bibclean,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.buildifier,
                null_ls.builtins.formatting.format_r,
                null_ls.builtins.formatting.qmlformat,
            },
        })

        null_ls.register(require('config.lsp.null_ls.gawk'))
        null_ls.register(require('config.lsp.null_ls.ispc'))
        null_ls.register(require('config.lsp.null_ls.shellcheck_pkgbuild'))
    end
}
