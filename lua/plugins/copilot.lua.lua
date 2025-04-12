return {
    'zbirenbaum/copilot.lua',

    config = function()
        require('copilot').setup({
            suggestion = {
                enabled = true,
                auto_trigger = false,
                hide_during_completion = true,
                debounce = 75,
                trigger_on_accept = true,

                keymap = {
                    accept = '<A-a>',
                    accept_line = '<A-A>',
                    accept_word = false,
                    next = '<A-n>',
                    prev = '<A-m>',
                    dismiss = '<A-e>',
                },
            },

            panel = {
                enabled = false,
            },
        })
    end
}
