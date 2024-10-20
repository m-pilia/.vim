return {
    'nvim-treesitter/nvim-treesitter',

    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            },
        })
    end
}
