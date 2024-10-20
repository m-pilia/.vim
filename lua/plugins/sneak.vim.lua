return {
    'justinmk/vim-sneak',

    init = function()
        vim.g['sneak#label'] = true

        -- 2-character Sneak
        vim.keymap.set({'n', 'x', 'o'}, '<leader><leader>w', '<Plug>Sneak_s', {})
        vim.keymap.set({'n', 'x', 'o'}, '<leader><leader>b', '<Plug>Sneak_S', {})

        -- 1-character enhanced 'f'
        vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>Sneak_f', {})
        vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>Sneak_F', {})

        -- 1-character enhanced 't'
        vim.keymap.set({'n', 'x', 'o'}, 't', '<Plug>Sneak_t', {})
        vim.keymap.set({'n', 'x', 'o'}, 'T', '<Plug>Sneak_T', {})
    end
}
