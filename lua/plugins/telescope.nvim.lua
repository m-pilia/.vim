return {
    'nvim-telescope/telescope.nvim',

    tag = 'v0.2.1',

    dependencies = {
        'nvim-lua/plenary.nvim',
    },

    config = function()
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        require('telescope').setup {
            defaults = {
                layout_strategy = 'vertical',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                    },
                },
                path_display = {
                    "truncate",
                },
            },
            pickers = {
                oldfiles = {
                    cwd_only = true,
                },
            },
        }

        vim.api.nvim_set_hl(0, 'TelescopeSelection', {link = 'CursorLineNr'})
        vim.api.nvim_set_hl(0, 'TelescopeMatching', {link = 'SpellBad'})

        vim.keymap.set('n', '<C-p>', builtin.find_files, {noremap = true})
        vim.keymap.set('n', '<C-h>', builtin.oldfiles, {noremap = true})
    end
}
