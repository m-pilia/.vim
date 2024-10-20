return {
    'preservim/vim-markdown',

    config = function()
        vim.g.vim_markdown_math = true
        vim.g.vim_markdown_frontmatter = true
        vim.g.vim_markdown_strikethrough = true
    end
}
