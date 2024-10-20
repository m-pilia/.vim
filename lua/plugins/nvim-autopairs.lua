local function spaces_between_parentheses(brackets, filetypes)
    local Rule = require('nvim-autopairs.rule')
    local autopairs = require('nvim-autopairs')
    local conds = require('nvim-autopairs.conds')

    autopairs.add_rules({
        Rule(' ', ' ', filetypes)
            :with_pair(function(opts)
                local pair = opts.line:sub(opts.col - #brackets[1], opts.col + #brackets[2] - 1)
                return pair == brackets[1] .. brackets[2]
            end)
            :with_move(conds.none())
            :with_cr(conds.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - #brackets[1], col + #brackets[2] + 1)
                return context == brackets[1] .. '  ' .. brackets[2]
            end)
    })

    autopairs.add_rules({
        Rule(brackets[1] .. ' ', ' ' .. brackets[2], filetypes)
            :with_pair(conds.none())
            :with_move(function(opts) return opts.char == brackets[2] end)
            :with_del(conds.none())
            :use_key(brackets[2])
            :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
    })
end

local function to_rules(brackets)
    local Rule = require('nvim-autopairs.rule')
    local result = {}

    for _, pair in pairs(brackets.brackets) do
        result[#result + 1] = Rule(pair[1], pair[2], brackets.filetype)
    end

    return result
end

local function escape_rules(char)
    local autopairs = require('nvim-autopairs')
    local conds = require('nvim-autopairs.conds')

    for _, rule in ipairs(autopairs.get_rule(char)) do
        rule:with_move(conds.not_before_text('\\'))
            :with_del(
                function(opts)
                    local prev_col = vim.api.nvim_win_get_cursor(0)[2] - 1
                    return opts.line:sub(prev_col, prev_col) ~= '\\'
                end
            )
    end
end

local brackets = {
    markdown = {
        filetype = {'markdown', 'liquid'},
        brackets = {
            {'```', '```'},
            {'{%', '%}'},
        },
    },
    tex = {
        filetype = 'tex',
        brackets = {
            {'$', '$'},
            {'\\left(', '\\right)'},
            {'\\left[', '\\right]'},
            {'\\left{', '\\right}'},
            {'\\left|', '\\right|'},
            {'\\lvert', '\\rvert'},
            {'\\lVert', '\\rVert'},
        },
    },
    all = {
        filetype = nil,
        brackets = {
            {'(', ')'},
            {'[', ']'},
            {'{', '}'},
        },
    }
}

return {
    'windwp/nvim-autopairs',

    event = 'InsertEnter',

    config = function()
        local Rule = require('nvim-autopairs.rule')
        local autopairs = require('nvim-autopairs')
        local conds = require('nvim-autopairs.conds')

        require('nvim-autopairs').setup({
            enable_bracket_in_quote = false,
            fast_wrap = {},
        })

        autopairs.add_rules(to_rules(brackets.tex))
        autopairs.add_rules({
            Rule('%', '%', {'liquid'}):with_pair(conds.before_text('{')),
        })

        for _, ft_brackets in pairs(brackets) do
            for _, pair in pairs(ft_brackets.brackets) do
                spaces_between_parentheses(pair, ft_brackets.filetype)
            end
        end

        for _, char in ipairs({"'", '"', '`'}) do
            escape_rules(char)
        end
    end
}
