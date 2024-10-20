return {
    'Wansmer/sibling-swap.nvim',

    dependencies = {
        'tpope/vim-obsession',
    },

    config = function()
        require('sibling-swap').setup({
            keymaps = {
                ['g>'] = 'swap_with_right',
                ['g<'] = 'swap_with_left',
                ['G>'] = 'swap_with_right_with_opp',
                ['G<'] = 'swap_with_left_with_opp',
            },
        })
    end
}
