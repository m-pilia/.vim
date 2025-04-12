local function get_adapter()
    if vim.env.GEMINI_API_KEY then
        return {
            chat = {
                adapter = 'gemini',
            },
            inline = {
                adapter = 'gemini',
            },
        }
    else
        return {
            chat = {
                adapter = 'copilot',
            },
            inline = {
                adapter = 'copilot',
            },
        }
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
            strategies = get_adapter(),
        })
    end
}
