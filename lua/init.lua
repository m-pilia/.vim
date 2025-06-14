vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'EE',
            [vim.diagnostic.severity.WARN] = 'WW',
            [vim.diagnostic.severity.INFO] = 'II',
            [vim.diagnostic.severity.HINT] = 'HH',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'SpellBad',
            [vim.diagnostic.severity.WARN] = 'Todo',
            [vim.diagnostic.severity.INFO] = 'Todo',
            [vim.diagnostic.severity.HINT] = 'Hint',
        },
    },

    update_in_insert = true,

    virtual_text = {
        format = function(d)
            return string.format('%s (%s): %s', d.code, d.source, d.message)
        end,
    },
})

local function set_location_list()
    pcall(function() vim.diagnostic.setloclist({buffer = 0, open = false}) end)
end

local diagnostic_au_group = vim.api.nvim_create_augroup('diagnostic_settings', {clear = true})
vim.api.nvim_create_autocmd('DiagnosticChanged', {callback = set_location_list, group = diagnostic_au_group})

require('config.lsp')
require('config.lazy')
