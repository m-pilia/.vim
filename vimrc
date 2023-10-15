set encoding=utf-8
scriptencoding utf-8

" Leader
nmap <space> <nop>
let g:mapleader = ' '

"{{{ Colors

command! SyntaxRegionName echo synIDattr(synID(line('.'), col('.'), 0), 'name')

" Color scheme
colorscheme tundra
set termguicolors
syntax enable

" File EOL formats
set fileformats=unix,dos,mac

" Doxygen highlighting
let g:doxygen_enhanced_color=1

augroup syntax_highlighting
    autocmd!

    " Syntax highlighting synchronization settings
    " Sync file from start (NOTE: slow but very precise)
    autocmd BufEnter * :syntax sync fromstart

    " Detect conflict markers
    autocmd BufEnter * call aux#detect_conflict_markers()
augroup END

"}}}

"{{{ UI

" Wild menu completion
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*~,*.pyc

" Ignore messages from completion menu
set shortmess+=c

set guicursor=
set mouse=
set noshowmode
set ruler
set signcolumn=yes
set cmdheight=1 " Height of the command bar
set showcmd
set hidden " Hide abandoned buffers

set backspace=eol,start,indent " Configure backspace

set whichwrap+=<,>,h,l,[,] " Configure keys to move over wrapped lines

" Search options
set ignorecase
set smartcase
set hlsearch " Highlight search results
set incsearch " Incremental search
set magic
if has('nvim')
    set inccommand=nosplit
endif

" Forward word search operator without jumping
nnoremap <silent> * :let @/='\<\C'.expand('<cword>').'\>'<cr>:set hls<cr>

set lazyredraw " Don't redraw while executing macros

set showmatch " Blink on matching brackets
set matchtime=2 " Matching brackets blink duration

" Grep options
set grepprg=rg\ --vimgrep\ --no-heading\ --column\ $*
set grepformat=%f:%l:%c:%m

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep!'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep!' : 'lgrep'

" Automatically open the quickfix/location list after command
augroup quickfix_commands
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" Line numbers
set number
set cursorline

" Open location list
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>L :copen<cr>

"}}}

"{{{ Buffer

" Enable filetype plugins and indentation
filetype plugin indent on

augroup buffer_auto
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif

    " Detect filetype on save
    autocmd BufWritePost * if &filetype == '' | filetype detect |  endif

    " .cuh extension for CUDA headers
    autocmd BufRead,BufNewFile *.cuh setlocal filetype=cuda

    " Close some windows with q
    autocmd FileType help,qf,markdown.lsp-hover nmap <buffer> <silent> q :q<cr>
augroup END

" Views
set viewdir=$HOME/.vim/views
set viewoptions-=options

" Read files after changes from outside
set autoread
" Trigger autoread
autocmd buffer_auto FocusGained,BufEnter * :silent! !

" Modeline settings
set nomodeline
set modelines=0

" Save file
nnoremap <Leader>w :w<CR>

" Number of commands in vim history
set history=5000

" Disable backups
set nobackup
set nowritebackup
set noswapfile

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Time (ms) between automatic updates
set updatetime=200

" Close buffer without closing window
command! Bd bp | bd#
command! Bw bp | bw#

" Close all buffers except for the current one
command! Bo %bd | e# | bd#

" Open scratch buffer
command! Scratch call aux#scratch()

" Diff options
set diffopt+=vertical

" Hex mode
command -bar HexMode silent call aux#hex#toggle_hex()

" Intel hex checksum
command! -range IHexChecksum <line1>,<line2>call aux#hex#ihex_checksum()

" Open specific project files
command! BazelFile call aux#bazel_file()
command! ClangdFile call aux#edit_file('.clangd')

"}}}

"{{{ Indent

" Text width
set textwidth=2000

" Set different text width inside comment regions
augroup comment_width <buffer>
    autocmd!
    autocmd FileType c,cpp,cuda,matlab,java,python,vim
                \ autocmd CursorMoved,CursorMovedI <buffer>
                \ :call aux#set_text_width('\v(Comment|doxygen)')
augroup END

let g:code_width = 120
let g:comment_width = 72

" Automatic line break
set linebreak

" No double spaces on join
set nojoinspaces

" Tab settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" tab lines without losing selection
vnoremap <s-tab> <gv
vnoremap <tab> >gv

set autoindent "Auto indent
set smartindent "Smart indent
set wrap "Wrap lines

" Fold settings
set foldlevel=99
set foldmethod=syntax " Careful, may be slow

"}}}

"{{{ Motion

" Esc shortcut
imap jk <esc>
vmap <leader>jk <esc>

" Map to [ and ]
nmap ò [
nmap à ]
omap ò [
omap à ]
xmap ò [
xmap à ]

" Lines around the cursor
set scrolloff=7

augroup motion
    autocmd!
    " Keep current line in the middle of the window
    autocmd CursorMoved,BufReadPost * exe "normal! zz"
augroup END

" Keep column when moving to first/last line
set nostartofline

set viminfo^=% " Remember info about open buffers on close

" Treat long lines as break lines
map j gj
map k gk
map $ g$
map 0 g0

" Disable unconvenient keys
call aux#disable_keys(['Up', 'Down', 'Left', 'Right', 'Home', 'End', 'PageUp', 'PageDown'])

" CamelCase word backspace
imap <silent> <C-w> <C-O>:let save_ve = &l:virtualedit<cr>
    \<C-o>:setlocal virtualedit=onemore<cr>
    \<C-o>"_db
    \<C-o>:let &l:virtualedit = save_ve<cr>

" Search for visual selection
vnoremap <silent> * <esc>/\V<c-r>=escape(aux#visual_selection(), '/\')<cr><cr>
vnoremap <silent> # <esc>?\V<c-r>=escape(aux#visual_selection(), '/\')<cr><cr>

" Remove search highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Cycle through buffers
nnoremap <leader>v :b#<CR>
nnoremap <leader>f :bn<CR>
nnoremap <leader>F :bp<CR>
nnoremap <leader>b :ls<CR>:b<space>

" Cd to the directory of the open buffer
nnoremap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" Behavior when switching between buffers
set switchbuf=useopen

" Always show tab line
set showtabline=2

" To match HTML tags with %
runtime macros/matchit.vim

" Tag navigation
set tagfunc=aux#tagfunc
nmap <silent> <leader>t <C-]>
nmap <silent> <leader>T g<C-]>

" Make the jump list behave like the tag stack
if has('nvim')
    set jumpoptions+=stack
end

"}}}

"{{{ Legacy status line

" Always show the status line
set laststatus=2

" colours for status line
hi User1 ctermfg=darkgrey ctermbg=grey guifg=darkgrey guibg=grey
hi User2 ctermfg=darkgrey ctermbg=grey guifg=darkgrey guibg=grey
hi User3 ctermfg=darkmagenta ctermbg=grey guifg=darkmagenta guibg=grey
" Format the status line
set statusline=%1*[%n]%*                " buffer number
set statusline+=%1*\ %y%*               " filetype
set statusline+=%3*\ %f%*               " filename
set statusline+=%1*\ %m\ %*             " modified flag
set statusline+=%{FugitiveStatusline()} " git branch
set statusline+=%1*%=%*                 " goto right side
set statusline+=%1*\ col:%*             " col: indicator
set statusline+=%2*%v%*                 " (virtual) col number
set statusline+=%2*\ \ %l%*             " line number
set statusline+=%1*/%L\ %*              " line tot
set statusline+=%1*(%p%%)%*             " line percentage

"}}}

"{{{ Editing

" Completion options
set completeopt=menuone,noselect

" Format options
set formatoptions=jcroql

" Do not ignore headers (for vim-unimpaired ]f and [f mappings)
set suffixes-=.h

" Replace visual selection with yanked ("0P) and yanked or deleted (P) text
vnoremap <leader>S <esc>:call aux#onemored('gv"_d"0P')<cr>
vnoremap <leader>s <esc>:call aux#onemored('gv"_dP')<cr>

" Put line
nnoremap <leader>u :put<cr>
nnoremap <leader>U :put!<cr>
nnoremap <leader>i :put +<cr>
nnoremap <leader>I :put! +<cr>

" Yank/paste to system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P

" Yank file name
nnoremap <silent> <leader>cp :let @" = expand('%')<cr><bar>:let @+ = expand('%')<cr>
nnoremap <silent> <leader>cP :let @" = expand('%:p')<cr><bar>:let @+ = expand('%:p')<cr>

" Move current line up and down
nnoremap <silent> @sj :m .+1<CR>==
nnoremap <silent> @sk :m .-2<CR>==
inoremap <silent> @sj <Esc>:m .+1<CR>==gi
inoremap <silent> @sk <Esc>:m .-2<CR>==gi
vnoremap <silent> @sj :m '>+1<CR>gv=gv
vnoremap <silent> @sk :m '<-2<CR>gv=gv

" Twiddle case
vnoremap <silent> ~ :call aux#twiddle_case()<cr>

" Convert between forward and backslash in visual selection
vnoremap <silent> <leader>\ :call aux#convert_path()<cr>

" F5 to run make
nnoremap <silent> <F5> :!make<cr>

" Write as sudo
cnoremap w!! w !sudo tee % >/dev/null

" Accept conflict region under cursor
nnoremap <silent> <leader>ga :call aux#accept_conflict_under_cursor()<cr>

" Toggle paste mode
set pastetoggle=<f10>

"}}}

"{{{ netrw

nnoremap <silent> - :Explore<cr>

let g:netrw_fastbrowse = 0
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_hide = 1
let g:netrw_list_hide = aux#netrw_list_hide()

"}}}

"{{{ terminal

tnoremap <Esc> <C-\><C-n>

if has('nvim')
    augroup nvim_terminal
        autocmd!
        autocmd TermOpen * startinsert
        autocmd WinEnter term://* startinsert
    augroup END
end

"}}}

"{{{ Development tools

" Prettyprint a vim object
command! -nargs=1 PP echo aux#pprint(<args>)

"}}}

""""""""""""""""""" Plugin settings

"{{{ pathogen

runtime bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
call pathogen#infect()

"}}}

"{{{ tcomment

let g:tcomment#rstrip_on_uncomment = 0
let g:tcomment_textobject_inlinecomment = 'Ic'
call tcomment#type#Define('asm', '# %s')

"}}}

"{{{ vimtex

let g:vimtex_complete_enabled = 0

"}}}

"{{{ python-syntax

let g:python_highlight_all = 1

"}}}

"{{{ vim-markdown

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1

"}}}

"{{{ auto-pairs

let g:AutoPairsShortcutFastWrap = '<C-S-e>'
let g:AutoPairsMultilineClose = v:false

"}}}

"{{{ lightline

let g:lightline = {
\   'colorscheme': 'wombat',
\   'component': {
\       'lineinfo': '%l/%L:%-v',
\       'filename': '%<%f %m',
\       'gitbranch': aux#lightline#git_status(),
\   },
\   'component_function': {
\       'fileformatandencoding': 'aux#lightline#file_info',
\   },
\   'component_expand': {
\       'warning_count': 'aux#lightline#warning_count',
\       'error_count': 'aux#lightline#error_count',
\   },
\   'component_type': {
\       'warning_count': 'warning',
\       'error_count': 'error',
\   },
\   'tab_component': {
\       'filename': '%f %m',
\   },
\   'active': {
\       'left': [
\           ['mode', 'paste'],
\           ['gitbranch', 'readonly', 'filename'],
\       ],
\       'right': [
\           ['percent'],
\           ['lineinfo'],
\           ['fileformatandencoding', 'filetype'],
\           ['warning_count', 'error_count'],
\       ],
\   },
\   'tabline': {
\       'left': [ [ 'tabs' ] ],
\       'right': [],
\   },
\ }

augroup lightline_settings
    autocmd!
    autocmd BufWinEnter * call aux#lightline#colours()
    autocmd User CocDiagnosticChange call lightline#update()
augroup END

"}}}

"{{{ UndoTree

nnoremap <F7> :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

"}}}

"{{{ vim-prosession

let g:prosession_on_startup = 1

"}}}

"{{{ vim-wordmotion

nnoremap W w
vnoremap W w
vnoremap iW iw
vnoremap aW aw
omap iW :normal ViW<cr>
omap aW :normal VaW<cr>

let g:wordmotion_mappings = {
            \   'w' : 'w',
            \   'b' : 'b',
            \   'e' : 'e',
            \   'ge' : 'ge',
            \   'aw' : 'aw',
            \   'iw' : 'iw',
            \   '<C-R><C-W>' : '<C-R><C-W>'
            \ }

"}}}

"{{{ vim-better-whitespace

let g:show_spaces_that_precede_tabs = 1
let g:better_whitespace_filetypes_blacklist = [
            \   'diff',
            \   'gitcommit',
            \   'unite',
            \   'qf',
            \   'help',
            \ ]

highlight link ExtraWhitespace SpellBad

"}}}

"{{{ editorconfig-vim

let g:EditorConfig_preserve_formatoptions = 1
let g:EditorConfig_exclude_patterns = [
            \ 'fugitive://.*',
            \ 'scp://.*',
            \ '.*/.git/.*',
            \ ]

"}}}

"{{{ coc.nvim

" Do not load in vimdiff
if &diff
    let g:did_coc_loaded = 1
endif

let g:coc_global_extensions = [
\       'coc-clangd',
\       'coc-cmake',
\       'coc-docker',
\       'coc-diagnostic',
\       'coc-json',
\       'coc-git',
\       'coc-groovy',
\       'coc-julia',
\       'coc-lists',
\       'coc-omni',
\       'coc-pyright',
\       'coc-rust-analyzer',
\       'coc-sh',
\       'coc-snippets',
\       'coc-texlab',
\       'coc-tsserver',
\       'coc-vimlsp',
\       'coc-yank',
\       ]

let g:coc_user_config = {
\   'coc': {
\       'preferences': {
\           'extensionUpdateCheck': 'never',
\           'previewAutoClose': v:false,
\       },
\       'source': {
\           'around': {'firstMatch': v:false},
\           'buffer': {'firstMatch': v:false},
\       },
\   },
\   'codeLens': {
\       'enable': v:false,
\   },
\   'diagnostic': {
\       'messageTarget': 'echo',
\       'checkCurrentLine': v:true,
\       'errorSign': 'EE',
\       'warningSign': 'WW',
\       'infoSign': 'II',
\       'hintSign': 'HH',
\   },
\   'suggest': {
\       'timeout': 5000,
\       'noselect': v:true,
\       'snippetIndicator': '►',
\   },
\   'semanticTokens': {
\       'filetypes': ['*'],
\   },
\   'tree': {
\       'key': {
\           'close': 'q',
\           'toggle': 'o',
\       },
\   },
\   'git': {
\       'addedSign': {'hlGroup': 'GutterAdd'},
\       'changedSign': {'hlGroup': 'GutterChange'},
\       'removedSign': {'hlGroup': 'GutterDelete'},
\       'topRemovedSign': {'hlGroup': 'GutterDelete'},
\       'changeRemovedSign': {'hlGroup': 'GutterChangeDelete'},
\       'conflict': {
\           'enabled': v:false,
\       },
\       'showCommitInFloating': v:true,
\   },
\   'list': {
\       'limitLines': 50000,
\       'source': {
\           'files': {
\               'command': 'fd',
\               'args': ['--type', 'f', '--color=never'],
\           },
\       },
\   },
\   'yank': {
\       'highlight': {'enable': v:false},
\       'enableCompletion': v:false,
\   },
\   'languageserver': aux#lsp#coc_config(),
\   'diagnostic-languageserver': {
\       'linters': aux#diagnostic#linters(),
\       'filetypes': {
\           'ada': 'gcc-ada',
\           'awk': 'gawk',
\           'bib': 'bibclean',
\           'cmake': 'cmakelint',
\           'dockerfile': 'hadolint',
\           'gitcommit': 'gitlint',
\           'ispc': 'ispc',
\           'make': 'checkmake',
\           'matlab': 'mlint',
\           'pkgbuild': 'shellcheck_pkgbuild',
\           'qml': 'qmllint',
\           'tex': 'chktex',
\           'vim': 'vint',
\       },
\   },
\   'rust-analyzer': {
\       'server': {
\           'path': '/usr/bin/rust-analyzer',
\       },
\   },
\   'python': {
\       'linting': {
\           'flake8Enabled': v:true,
\           'banditEnabled': v:true,
\           'mypyEnabled': v:true,
\           'pytypeEnabled': v:true,
\           'pycodestyleEnabled': v:false,
\           'prospectorEnabled': v:true,
\           'pydocstyleEnabled': v:false,
\           'pylamaEnabled': v:true,
\           'pylintEnabled': v:false,
\       },
\   },
\ }

highlight link CocErrorHighlight CocErrorSign
highlight link CocErrorSign SpellBad
highlight link CocHighlightText CursorColumn
highlight link CocHintHighlight CocHintSign
highlight link CocHintSign Hint
highlight link CocInfoHighlight SpellCap
highlight link CocInfoSign CocWarningSign
highlight link CocInlayHint Ignore
highlight link CocListSearch SpellBad
highlight link CocMenuSel PmenuSel
highlight link CocSemClass Type
highlight link CocSemComment Comment
highlight link CocSemEnumMember Normal
highlight link CocSemFunction Function
highlight link CocSemMacro Define
highlight link CocSemMethod Function
highlight link CocSemNamespace Normal
highlight link CocSemParameter Normal
highlight link CocSemStruct Type
highlight link CocSemTypeParameter Type
highlight link CocSemVariable Normal
highlight link CocWarningHighlight SpellCap
highlight link CocWarningSign Todo

augroup coc_list
    autocmd!
    " CocListLine seems to no longer work in recent releases
    autocmd FileType list set winhighlight=CursorLine:CursorLineNr
augroup END

" Mappings
nmap <silent> <leader>,ca <plug>(coc-code-action)
vmap <silent> <leader>,ca <plug>(coc-code-action-selected)
nmap <silent> <leader>,cl <plug>(coc-codelens-action)
nmap <silent> <leader>,gD <plug>(coc-declaration)
nmap <silent> <leader>,gd <plug>(coc-definition)
nnoremap <silent> <leader>,h  :call CocActionAsync('doHover')<cr>
nmap <silent> <leader>,l  <plug>(coc-open-link)
nmap <silent> <leader>,e  <plug>(coc-diagnostic-next)
nmap <silent> <leader>,E  <plug>(coc-diagnostic-prev)
nmap <silent> <leader>,rf <plug>(coc-references)
nmap <silent> <leader>,r  <plug>(coc-rename)
nmap <silent> <leader>,R  <plug>(coc-refactor)
nmap <silent> <leader>,f  <plug>(coc-fix-current)
nmap <silent> <leader>,df <plug>(coc-format)
vmap <silent> <leader>,df <plug>(coc-format-selected)
nmap <silent> <leader>,i  <plug>(coc-implementation)
nmap <silent> <leader>,td <plug>(coc-type-definition)
nnoremap <silent> <leader>l :CocDiagnostics<cr>
nnoremap <silent> <leader>,j :CocCommand document.jumpToNextSymbol<cr>
nnoremap <silent> <leader>,k :CocCommand document.jumpToPrevSymbol<cr>
nnoremap <silent> <leader>,ch :call CocAction('showIncomingCalls')<cr>
nnoremap <silent> <leader>,cH :call CocAction('showOutgoingCalls')<cr>
nnoremap <silent> <leader>,th :call CocAction('showSubTypes')<cr>
nnoremap <silent> <leader>,tH :call CocAction('showSuperTypes')<cr>
nnoremap <silent> <leader>,o :call CocAction('showOutline')<cr>

" Scroll float window
nnoremap <silent> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-f>"
nnoremap <silent> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-b>"
inoremap <silent> <expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
inoremap <silent> <expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<Left>"

" Completion mappings
inoremap <silent> <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent> <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent> <expr> <c-j>
\   coc#expandableOrJumpable() ?
\   "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
\   coc#pum#visible() ? coc#pum#confirm() : "\<c-j>"
inoremap <silent> <expr> <c-space> coc#refresh()

" Git mappings
nmap <silent> ]h <Plug>(coc-git-nextchunk)
nmap <silent> [h <Plug>(coc-git-prevchunk)
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
nmap <silent> <leader>gu :CocCommand git.chunkUndo<cr>
nmap <silent> <leader>gs :CocCommand git.chunkStage<cr>
omap ih <Plug>(coc-git-chunk-inner)
xmap ih <Plug>(coc-git-chunk-inner)
omap ah <Plug>(coc-git-chunk-outer)
xmap ah <Plug>(coc-git-chunk-outer)

" List mappings
nnoremap <leader>. :CocList vimcommands<cr>
nnoremap <silent> <C-p> :CocList files<cr>
nnoremap <silent> <C-h> :CocCommand mru.validate<cr>:CocList mru<cr>
nnoremap <silent> <C-k> :CocList buffers<cr>
nnoremap <silent> <C-j> :CocList yank<cr>

" Show info for semantic token under the cursor
command! SemanticToken call CocAction('inspectSemanticToken')

" Reference highlight
if ! &diff && index(g:pathogen_disabled, 'coc.nvim') < 0
    augroup coc_highlight
        autocmd!
        autocmd CursorHold * silent call aux#refresh_highlighting()
        autocmd CursorHoldI * silent call aux#show_signature_help()
    augroup END
endif

"}}}

"{{{ vim-textobj-parameter

let g:vim_textobj_parameter_mapping = 'a'

"}}}

"{{{ vim-textobj-function

let g:textobj_function_no_default_key_mappings = 1

xmap if <Plug>(textobj-function-i)
omap if <Plug>(textobj-function-i)
xmap af <Plug>(textobj-function-A)
omap af <Plug>(textobj-function-A)

"}}}

"{{{ vim-textobj-functioncall

let g:textobj_functioncall_no_default_key_mappings = 1

xmap iF <Plug>(textobj-functioncall-i)
omap iF <Plug>(textobj-functioncall-i)
xmap aF <Plug>(textobj-functioncall-a)
omap aF <Plug>(textobj-functioncall-a)

"}}}

"{{{ vim-endwise

let g:endwise_no_mappings = 1
imap <C-x><cr> <cr><plug>AlwaysEnd
imap <cr> <cr><plug>DiscretionaryEnd

"}}}

"{{{ vim-diffchar

let g:DiffUnit = 'Char'

"}}}

"{{{ vim-mediawiki

let g:vim_mediawiki_browser_command = "firefox \r"
let g:vim_mediawiki_mappings = 1
let g:vim_mediawiki_completion_namespaces = {
\   'en.wikipedia.org': {
\       '[[': 0,
\       '[[Talk:': 1,
\       '[[User:': 2,
\       '[[User talk:': 3,
\       '[[Wikipedia:': 4,
\       '[[Wikipedia talk:': 5,
\       '[[File:': 6,
\       '[[:File:': 6,
\       '[[File talk:': 7,
\       '[[MediaWiki:': 8,
\       '[[MediaWiki talk:': 9,
\       '[[Template:': 10,
\       '{{': 10,
\       '[[Template talk:': 11,
\       '[[Help:': 12,
\       '[[Help talk:': 13,
\       '[[Category:': 14,
\       '[[:Category:': 14,
\       '[[Category talk:': 15,
\       '[[Portal:': 100,
\       '[[Portal talk:': 101,
\       '[[Book:': 108,
\       '[[Book talk:': 109,
\       '[[Draft:': 118,
\       '[[Draft talk:': 119,
\       '[[TimedText:': 710,
\       '[[TimedText talk:': 711,
\       '[[Module:': 828,
\       '[[Module talk:': 829,
\   },
\   'it.wikipedia.org': {
\       '[[': 0,
\       '{{': 10,
\       '[[File:': 6,
\       '[[:File:': 6,
\       '[[Categoria:': 14,
\       '[[:Categoria:': 14,
\   },
\ }

"}}}

"{{{ vim-sneak

let g:sneak#label = 1

" 2-character Sneak
nmap <leader><leader>w <Plug>Sneak_s
xmap <leader><leader>w <Plug>Sneak_s
omap <leader><leader>w <Plug>Sneak_s
nmap <leader><leader>b <Plug>Sneak_S
xmap <leader><leader>b <Plug>Sneak_S
omap <leader><leader>b <Plug>Sneak_S

" 1-character enhanced 'f'
nmap f <Plug>Sneak_f
xmap f <Plug>Sneak_f
omap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap F <Plug>Sneak_F
omap F <Plug>Sneak_F

" 1-character enhanced 't'
nmap t <Plug>Sneak_t
xmap t <Plug>Sneak_t
omap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap T <Plug>Sneak_T
omap T <Plug>Sneak_T

"}}}

"{{{ neoterm

let g:neoterm_autoinsert = v:true
let g:neoterm_default_mod = 'botright vertical'

nmap gr <Plug>(neoterm-repl-send)
xmap gr <Plug>(neoterm-repl-send)
nmap gl <Plug>(neoterm-repl-send-line)

"}}}
