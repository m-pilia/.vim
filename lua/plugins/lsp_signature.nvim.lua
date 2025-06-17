return {
    'ray-x/lsp_signature.nvim',

    config = function()
        require('lsp_signature').setup({})

        vim.keymap.set('i', '<C-s>', function()
            require('lsp_signature').toggle_float_win()
        end, {silent = true, noremap = true})
    end
}
