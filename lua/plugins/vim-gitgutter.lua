return {
    'airblade/vim-gitgutter',

    config = function()
        vim.g.gitgutter_map_keys = false

        vim.keymap.set('n', '<leader>gi', '<Plug>(GitGutterPreviewHunk)')
        vim.keymap.set('n', '<leader>gu', '<Plug>(GitGutterUndoHunk)')
        vim.keymap.set('n', '<leader>gs', '<Plug>(GitGutterStageHunk)')

        vim.keymap.set('n', ']h', '<Plug>(GitGutterNextHunk)')
        vim.keymap.set('n', '[h', '<Plug>(GitGutterPrevHunk)')

        vim.api.nvim_set_hl(0, 'diffAdded', {link = 'DiffAdd'})
        vim.api.nvim_set_hl(0, 'diffChanged', {link = 'DiffChange'})
        vim.api.nvim_set_hl(0, 'diffRemoved', {link = 'DiffDelete'})
    end
}
