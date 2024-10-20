return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require("nvim-autopairs").setup {}

        local Rule = require('nvim-autopairs.rule')
        local autopairs = require('nvim-autopairs')

        autopairs.add_rules({
            Rule('{%', '%}', {"markdown"})
        })
    end
}
