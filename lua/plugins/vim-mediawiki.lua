return {
    'm-pilia/vim-mediawiki',

    config = function()
        vim.g.vim_mediawiki_browser_command = "firefox \r"
        vim.g.vim_mediawiki_mappings = 1
        vim.g.vim_mediawiki_completion_namespaces = {
            ['en.wikipedia.org'] = {
                ['[['] = 0,
                ['[[Talk:'] = 1,
                ['[[User:'] = 2,
                ['[[User talk:'] = 3,
                ['[[Wikipedia:'] = 4,
                ['[[Wikipedia talk:'] = 5,
                ['[[File:'] = 6,
                ['[[:File:'] = 6,
                ['[[File talk:'] = 7,
                ['[[MediaWiki:'] = 8,
                ['[[MediaWiki talk:'] = 9,
                ['[[Template:'] = 10,
                ['{{'] = 10,
                ['[[Template talk:'] = 11,
                ['[[Help:'] = 12,
                ['[[Help talk:'] = 13,
                ['[[Category:'] = 14,
                ['[[:Category:'] = 14,
                ['[[Category talk:'] = 15,
                ['[[Portal:'] = 100,
                ['[[Portal talk:'] = 101,
                ['[[Book:'] = 108,
                ['[[Book talk:'] = 109,
                ['[[Draft:'] = 118,
                ['[[Draft talk:'] = 119,
                ['[[TimedText:'] = 710,
                ['[[TimedText talk:'] = 711,
                ['[[Module:'] = 828,
                ['[[Module talk:'] = 829,
            },
            ['it.wikipedia.org'] = {
                ['[['] = 0,
                ['{{'] = 10,
                ['[[File:'] = 6,
                ['[[:File:'] = 6,
                ['[[Categoria:'] = 14,
                ['[[:Categoria:'] = 14,
            },
        }
    end
}
