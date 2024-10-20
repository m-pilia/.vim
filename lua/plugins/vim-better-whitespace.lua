return {
    'ntpeters/vim-better-whitespace',

    config = function()
        vim.g.show_spaces_that_precede_tabs = true
        vim.g.better_whitespace_filetypes_blacklist = {
            'diff',
            'gitcommit',
            'unite',
            'qf',
            'help',
        }

        vim.api.nvim_set_hl(0, 'ExtraWhitespace', {link = 'SpellBad'})
    end
}
