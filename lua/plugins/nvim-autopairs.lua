return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        local Rule = require('nvim-autopairs.rule')
        local autopairs = require('nvim-autopairs')

        autopairs.add_rules({
            Rule('{%', '%}', {"markdown"})
        })
    end
}
