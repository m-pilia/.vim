return {
    'neovim/nvim-lspconfig',

    config = function()
        require('lspconfig').bashls.setup({})
        require('lspconfig').clangd.setup({})
        require('lspconfig').jsonls.setup({})
        require('lspconfig').lua_ls.setup(require('config.lsp.lua_ls'))
        require('lspconfig').pyright.setup({})
        require('lspconfig').qmlls.setup({})
        require('lspconfig').vimls.setup({})

        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                update_in_insert = true,
            }
        )
    end
}
