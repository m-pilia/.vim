return {
    'nvim-treesitter/nvim-treesitter-context',

    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },

    config = function()
        require('treesitter-context').setup({
            multiline_threshold = 5,
        })

        -- Separator
        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {underline = true, sp = '#54ffff'})
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', {link = 'TreesitterContextBottom'})
    end
}
