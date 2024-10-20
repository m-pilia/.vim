return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'm-pilia/vim-pkgbuild',  -- for pkgbuild#diagnostic_languageserver
    },

    config = function()
        require'lspconfig'.clangd.setup{}
        require'lspconfig'.diagnosticls.setup(require('config.lsp.diagnostic-languageserver-config'))
        require'lspconfig'.lua_ls.setup(require('config.lsp.lua_ls'))
        require'lspconfig'.pyright.setup{}
        require'lspconfig'.qmlls.setup{}
        require'lspconfig'.vimls.setup{}
    end
}
