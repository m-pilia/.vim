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
})

-- Built-in autocompletion
local lsp_au_group = vim.api.nvim_create_augroup('lsp_au_group', {clear = true})
vim.api.nvim_create_autocmd({'LspAttach'}, {
    callback = function()
        local clients = vim.lsp.get_clients()
        for _, client in ipairs(clients) do
            local id = client.id
            vim.lsp.completion.enable(true, id, 0, {autotrigger = true})
            return
        end
    end,
    group = lsp_au_group,
})

require("config.lazy")
