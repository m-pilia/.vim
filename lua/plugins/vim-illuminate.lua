return {
    'RRethy/vim-illuminate',

    config = function()
        require('illuminate').configure({
            providers = {
                'lsp',
            },
            delay = 100,
        })

        vim.api.nvim_set_hl(0, 'IlluminatedWordText', {link = 'CursorColumn'})
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {link = 'IlluminatedWordText'})
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {link = 'IlluminatedWordText'})
    end
}
