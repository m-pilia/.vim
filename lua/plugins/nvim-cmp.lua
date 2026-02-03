-- Entries with higher source priority will be ranked higher
local function priority_comparator(entry1, entry2)
    local diff = entry1.source:get_source_config().priority - entry2.source:get_source_config().priority
    if diff > 0 then
        return true
    elseif diff < 0 then
        return false
    end
    return nil
end

return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'kdheepak/cmp-latex-symbols',
        'onsails/lspkind.nvim',
        'saadparwaiz1/cmp_luasnip',
        'tamago324/cmp-zsh',
    },

    config = function()
        require('vim-mediawiki.cmp_mediawiki')
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')

        require('cmp_zsh').setup({
            zshrc = true,
            filetypes = {
                'zsh',
            }
        })

        cmp.setup({
            completion = {
                keyword_length = 1,
                keyword_pattern = [[\k\+]]
            },

            formatting = {
                format = function(entry, vim_item)
                    local lspkind_format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = {
                            menu = function() return math.floor(0.45 * vim.o.columns) end,
                            abbr = function() return math.floor(0.20 * vim.o.columns) end,
                        },
                        show_labelDetails = true,
                        symbol_map = {
                            Copilot = '',
                            gemini = '✧',
                        },
                    })

                    vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', {link = 'Special'})

                    -- Show source name in the pum
                    vim_item.menu = entry.source.name

                    return lspkind_format(entry, vim_item)
                end
            },

            sorting = {
                comparators = {
                    priority_comparator,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },

            sources = {
                {
                    name = 'path',
                    priority = 95,
                },
                {
                    name = 'nvim_lsp',
                    priority = 90,
                },
                {
                    name = 'cmp_mediawiki',
                    priority = 90,
                },
                {
                    name = 'copilot',
                    priority = 85,
                },
                {
                    name = 'luasnip',
                    priority = 80,
                },
                {
                    name = 'emoji',
                    priority = 50,
                },
                {
                    name = 'latex_symbols',
                    priority = 50,
                },
                {
                    name = 'nvim_lua',
                    priority = 50,
                },
                {
                    name = 'nvim_lsp_signature_help',
                    priority = 50,
                },
                {
                    name = 'zsh',
                    priority = 50,
                },
                {
                    name = 'buffer',
                    priority = 10,
                },
            },

            performance = {
                fetching_timeout = 2000,
            },

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            mapping = {
                ['<C-j>'] = cmp.mapping(
                    function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.confirm({
                                select = true,
                            })
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),

                ['<C-k>'] = cmp.mapping(
                    function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),

                ['<Tab>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),

                ['<S-Tab>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),

                ['<c-space>'] = cmp.mapping {
                    i = cmp.mapping.complete(),
                },

                ['<c-e>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
            },
        })
    end
}
