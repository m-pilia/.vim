return {
    'milanglacier/minuet-ai.nvim',

    dependencies = {
        'hrsh7th/nvim-cmp',
        'nvim-lua/plenary.nvim',
    },

    config = function()
        if not vim.env.GEMINI_API_KEY then
            return
        end

        require('minuet').setup({
            provider = 'gemini',

            virtualtext = {
                auto_trigger_ft = {},

                keymap = {
                    accept = '<A-a>',
                    accept_line = '<A-A>',
                    accept_n_lines = '<A-z>',
                    prev = '<A-n>',
                    next = '<A-m>',
                    dismiss = '<A-e>',
                },
            },
        })
    end
}
