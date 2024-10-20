return {
    'dhruvasagar/vim-prosession',

    dependencies = {
        'tpope/vim-obsession',
    },

    config = function()
        vim.g.prosession_on_startup = true
        vim.g.prosession_dir = '~/.config/nvim/session/'
    end
}
