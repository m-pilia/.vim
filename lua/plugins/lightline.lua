local function git_status()
    local result  = '%{FugitiveHead() == "" ? "no repo" : FugitiveHead()}'
    local open    = '%{aux#lightline#has_hunks() ? "  (" : ""}'
    local close   = '%{aux#lightline#has_hunks() ? ")" : ""}'
    local added   = '%#GitStatusLineAdd#%{aux#lightline#git_added()}'
    local changed = '%#GitStatusLineChange#%{aux#lightline#git_changed()}'
    local deleted = '%#GitStatusLineDelete#%{aux#lightline#git_deleted()}'
    local reset_colour = '%#LightlineLeft_active_1#'
    return result .. open .. added .. changed .. deleted .. reset_colour .. close
end

local function set_location_list()
    vim.diagnostic.setloclist{buffer = 0, open = false}
end

return {
    'itchyny/lightline.vim',

    config = function()
        vim.api.nvim_set_hl(0, 'GitGutterAdd', {link = 'GutterAdd'})
        vim.api.nvim_set_hl(0, 'GitGutterChange', {link = 'GutterChange'})
        vim.api.nvim_set_hl(0, 'GitGutterDelete', {link = 'GutterDelete'})

        vim.g.lightline = {
            colorscheme = 'wombat',
            component = {
                lineinfo = '%l/%L:%-v',
                filename = '%<%f %m',
                gitbranch = git_status(),
            },
            component_function = {
                fileformatandencoding = 'aux#lightline#file_info',
            },
            component_expand = {
                warning_count = 'aux#lightline#warning_count',
                error_count = 'aux#lightline#error_count',
            },
            component_type = {
                warning_count = 'warning',
                error_count = 'error',
            },
            tab_component = {
                filename = '%f %m',
            },
            active = {
                left = {
                    {'mode', 'paste'},
                    {'gitbranch', 'readonly', 'filename'},
                },
                right = {
                    {'percent'},
                    {'lineinfo'},
                    {'fileformatandencoding', 'filetype'},
                    {'warning_count', 'error_count'},
                },
            },
            tabline = {
                left = { { 'tabs' } },
                right = {},
            },
        }

        local au_group = vim.api.nvim_create_augroup('lightline_settings', { clear = true })
        vim.api.nvim_create_autocmd('BufWinEnter', {pattern = '*', callback = 'aux#lightline#colours', group = au_group})
        vim.api.nvim_create_autocmd('User', {pattern = 'GitGutter', callback = 'lightline#update', group = au_group})
        vim.api.nvim_create_autocmd('DiagnosticChanged', {callback = 'lightline#update', group = au_group})
        vim.api.nvim_create_autocmd('DiagnosticChanged', {callback = set_location_list, group = au_group})
    end
}
