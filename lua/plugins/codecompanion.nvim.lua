local function get_adapter()
    if vim.env.NVIM_CODECOMPANION_STRATEGY == 'mistral' then
        return {
            chat = {
                adapter = 'mistral_vibe',
            },
            inline = {
                adapter = 'mistral_vibe',
            },
        }
    elseif vim.env.NVIM_CODECOMPANION_STRATEGY == 'copilot' then
        return {
            chat = {
                adapter = 'copilot',
            },
            inline = {
                adapter = 'copilot',
            },
        }
    else
        return {}
    end
end

return {
    'olimorris/codecompanion.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },

    config = function()
        require('codecompanion').setup({
            ignore_warnings = false,
            interactions = get_adapter(),
        })
    end
}
