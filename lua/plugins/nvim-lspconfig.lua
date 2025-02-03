return {
    'neovim/nvim-lspconfig',

    config = function()
        local lspconfig = require('lspconfig')

        lspconfig.bashls.setup({})
        lspconfig.bazelrc_lsp.setup({})
        lspconfig.clangd.setup({})
        lspconfig.jsonls.setup({})
        lspconfig.lua_ls.setup(require('config.lsp.lua_ls'))
        lspconfig.pyright.setup({})
        lspconfig.qmlls.setup({})
        lspconfig.starpls.setup(require('config.lsp.starpls'))
        lspconfig.vimls.setup({})

        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                update_in_insert = true,
            }
        )
    end
}
