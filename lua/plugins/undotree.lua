return {
    'mbbill/undotree',

    config = function()
        vim.keymap.set('n', '<F7>', vim.cmd.UndotreeToggle)
        vim.g.undotree_SetFocusWhenToggle = true
    end
}
