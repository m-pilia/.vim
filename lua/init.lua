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

    virtual_text = {
        format = function(d)
            return string.format('%s (%s): %s', d.code, d.source, d.message)
        end,
    },
})

local function set_location_list()
    pcall(function() vim.diagnostic.setloclist({buffer = 0, open = false}) end)
end

local function open_diagnostic_float()
    vim.diagnostic.open_float({focusable = false})
end

local diagnostic_au_group = vim.api.nvim_create_augroup('diagnostic_settings', {clear = true})
vim.api.nvim_create_autocmd('DiagnosticChanged', {callback = set_location_list, group = diagnostic_au_group})
vim.api.nvim_create_autocmd('CursorHold', {callback = open_diagnostic_float, group = diagnostic_au_group})

require('config.lazy')
