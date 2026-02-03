return {
    'nvim-treesitter/nvim-treesitter',

    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = {
                'bash',
                'c',
                'cpp',
                'cuda',
                'cpp',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'rust',
                'vim',
                'vimdoc',
            },

            highlight = {
                enable = true,
                disable = {
                    'c',
                    'cpp',
                    'cuda',
                    'gitcommit',
                    'gitrebase',
                },
            },
        })
    end
}
