return {
    'dhruvasagar/vim-prosession',

    dependencies = {
        'tpope/vim-obsession',
    },

    config = function()
        vim.g.prosession_on_startup = true
        vim.g.prosession_dir = vim.fn.expand('~/.local/share/nvim/session')

        local mode = 493 -- 0755
        vim.uv.fs_mkdir(vim.g.prosession_dir, mode)
    end
}
