return {
    'chaoren/vim-wordmotion',

    config = function()
        vim.keymap.set({'n', 'v'}, 'W', 'w', {noremap = true})
        vim.keymap.set('v', 'iW', 'iw', {noremap = true})
        vim.keymap.set('v', 'aW', 'aw', {noremap = true})
        vim.keymap.set('o', 'iW', ':normal ViW<cr>', {})
        vim.keymap.set('o', 'aW', ':normal VaW<cr>', {})

        vim.g.wordmotion_mappings = {
            w = 'w',
            b = 'b',
            e = 'e',
            ge = 'ge',
            aw = 'aw',
            iw = 'iw',
            ['<C-R><C-W>'] = '<C-R><C-W>'
        }
    end
}
