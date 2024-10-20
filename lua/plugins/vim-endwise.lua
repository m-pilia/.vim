return {
    'tpope/vim-endwise',

    config = function()
        vim.g.endwise_no_mappings = true

        vim.keymap.set('i', '<C-x><cr>', '<cr><plug>AlwaysEnd')
        vim.keymap.set('i', '<cr>', '<cr><plug>DiscretionaryEnd')
    end
}
