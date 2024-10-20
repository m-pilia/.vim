return {
    'akinsho/git-conflict.nvim',

    version = '*',

    config = function()
        require('git-conflict').setup({
            highlights = {
                current = 'ConflictCurrent',
                incoming = 'ConflictIncoming',
            },

            default_mappings = {
                ours = 'gco',
                theirs = 'gct',
                none = 'gcn',
                both = 'gcb',
                next = '[c',
                prev = ']c',
            },
        })
    end
}
