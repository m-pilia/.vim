set encoding=utf-8
scriptencoding utf-8

"{{{ Fundamentals

" Leader
nmap <space> <nop>
let mapleader = ' '
let g:mapleader = ' '
set showcmd

" Esc shortcut
imap jk <esc>
imap JK <esc>
vmap <leader>jk <esc>
vmap <leader>JK <esc>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Load plugins with pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
call pathogen#infect()

"}}}

"{{{ Colors

syntax enable " Enable syntax highlighting
command! SyntaxRegionName echo synIDattr(synID(line("."), col("."), 0), "name")

" Color scheme
colorscheme desert
set background=dark
highlight comment ctermfg=lightblue guifg=lightblue
highlight constant ctermfg=red guifg=red
highlight SpellBad ctermfg=white ctermbg=darkred guifg=white guibg=darkred
highlight SpellCap ctermfg=white ctermbg=brown guifg=white guibg=brown
highlight SignColumn ctermbg=black guibg=black
highlight GitGutterAdd ctermbg=black ctermfg=green guibg=black guifg=green
highlight GitGutterChange ctermbg=black ctermfg=yellow guibg=black guifg=yellow
highlight GitGutterDelete ctermbg=black ctermfg=red guibg=black guifg=red
highlight GitGutterChangeDelete ctermbg=black ctermfg=yellow guibg=black guifg=yellow

" GUI options
if has('gui_running')
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" File EOL formats
set fileformats=unix,dos,mac

" Doxygen highlighting
let g:doxygen_enhanced_color=1
augroup syntax_highlighting
    autocmd!
    autocmd FileType c :set syntax=c.doxygen
    autocmd FileType cpp :set syntax=cpp.doxygen
    autocmd FileType java :set syntax=java.doxygen
    autocmd FileType idl :set syntax=idl.doxygen
    autocmd FileType php :set syntax=php.doxygen

    " Syntax highlighting synchronization settings
    " See http://vimdoc.sourceforge.net/htmldoc/syntax.html#:syn-sync
    "
    " Sync file from start (NOTE: slow but very precise)
    autocmd BufEnter * :syntax sync fromstart

    " Suppress PKGBUILD.vim from Arch development tools
    autocmd BufNewFile,BufRead PKGBUILD set filetype=pkgbuild
augroup END

"}}}

"{{{ UI

" Wild menu completion
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*~,*.pyc

set guicursor=
set mouse=
set noshowmode
set ruler
set signcolumn=yes
set cmdheight=1 " Height of the command bar
set hidden " Hide abandoned buffers

set backspace=eol,start,indent " Configure backspace

set whichwrap+=<,>,h,l,[,] " Configure keys to move over wrapped lines

" Search options
set ignorecase
set smartcase
set hlsearch " Highlight search results
set incsearch " Incremental search
set magic

set lazyredraw " Don't redraw while executing macros

set showmatch " Blink on matching brackets
set matchtime=2 " Matching brackets blink duration

" Grep options
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" Line numbers
set number
highlight LineNr ctermfg=grey guifg=grey
set cursorline
highlight CursorLine term=NONE cterm=NONE guibg=NONE

" Open location list
nnoremap <leader><l :lopen<cr>

" Popup menu
highlight Pmenu ctermbg=darkgray guibg=darkgray

"}}}

"{{{ Buffer

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
command! Bd b# | bd #

" Diff options
set diffopt+=vertical

"}}}

"{{{ Indent

" Text width
set textwidth=2000

" Set different text width inside comment regions
augroup comment_width <buffer>
    autocmd!
    autocmd FileType c,cpp,cuda,java,python
                \ autocmd CursorMoved,CursorMovedI <buffer>
                \ :call aux#set_text_width('\v(Comment|doxygen)', 72, 120)
augroup END

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

augroup indentation
    autocmd!

    " Short tab width for functional languages and some markup languages
    autocmd FileType ocaml,sml,racket,haskell,yaml setlocal shiftwidth=2
    autocmd FileType ocaml,sml,racket,haskell,yaml setlocal tabstop=2

    " Wrap lines in diff
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif
augroup END

"}}}

"{{{ Motion

" Map to [ and ]
nmap ò [
nmap à ]
omap ò [
omap à ]
xmap ò [
xmap à ]

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

" Lines around the cursor
set scrolloff=7

" Disable arrows
map <C-Up> <nop>
map <C-Down> <nop>
map <C-Left> <nop>
map <C-Right> <nop>
imap <C-Up> <nop>
imap <C-Down> <nop>
imap <C-Left> <nop>
imap <C-Right> <nop>
vmap <C-Up> <nop>
vmap <C-Down> <nop>
vmap <C-Left> <nop>
vmap <C-Right> <nop>
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
imap <Up> <nop>
imap <Down> <nop>
imap <Left> <nop>
imap <Right> <nop>
vmap <Up> <nop>
vmap <Down> <nop>
vmap <Left> <nop>
vmap <Right> <nop>
map <Home> <nop>
map <End> <nop>
map <PageUp> <nop>
map <PageDown> <nop>
imap <Home> <nop>
imap <End> <nop>
imap <PageUp> <nop>
imap <PageDown> <nop>
vmap <Home> <nop>
vmap <End> <nop>
vmap <PageUp> <nop>
vmap <PageDown> <nop>

" CamelCase word backspace
imap <silent> <C-w> <C-o>:set virtualedit+=onemore<cr><C-o>db<C-o>:set virtualedit-=onemore<cr>

" Search for visual selection
vnoremap <silent> * <esc>/<c-r>*<cr>
vnoremap <silent> # <esc>?<c-r>*<cr>

" Remove search highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh <bar> :CtrlSFClearHL<cr>

" Cycle through buffers
nnoremap <leader>f :bn<CR>
nnoremap <leader>F :bp<CR>
nnoremap <leader>b :ls<CR>:b<space>

" Cd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Behavior when switching between buffers
set switchbuf=useopen

" Always show tab line
set showtabline=2

" Show help for the word under cursor
nnoremap <silent> <leader>h :help <c-r>=aux#vimhelp()<cr><cr>

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

" Replace visual selection with yanked ("0P) and yanked or deleted (P) text
vnoremap <leader>S "_d"0P
vnoremap <leader>s "_dP

" Copy-paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" auto switch paste mode when pasting (requires +clipboard)
inoremap <silent> <C-v> <space><backspace><Esc>:call aux#auto_paste()<cr>a

" Move current line up and down
nnoremap <silent> <C-S-j> :m .+1<CR>==
nnoremap <silent> <C-S-k> :m .-2<CR>==
inoremap <silent> <C-S-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-S-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-S-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-S-k> :m '<-2<CR>gv=gv

" Twiddle case
vnoremap <silent> ~ :call aux#twiddle_case()<cr>

" Convert between forward and backslash in visual selection
vnoremap <silent> <leader>\ :call aux#convert_path()<cr>

" F5 to run make
nnoremap <silent> <F5> :!make<cr>

" Write as sudo
cnoremap w!! w !sudo tee % >/dev/null

"}}}

"{{{ termdebug

packadd termdebug
nmap <leader>qb :Break<cr>
nmap <leader>qB :Clear<cr>
nmap <leader>qs :Step<cr>
nmap <leader>qo :Over<cr>
nmap <leader>qf :Finish<cr>
nmap <leader>qc :Continue<cr>
nmap <leader>qS :Stop<cr>
nmap <leader>qe :Evaluate<cr>

"}}}

""""""""""""""""""" Plugin settings

"{{{ Ultisnips

let g:UltiSnipsExpandTrigger='<not_needed>'

"}}}

"{{{ Screenshell

" Choose terminal multiplexer ('GnuScreen' or 'Tmux')
let g:ScreenImpl = 'GnuScreen'

" Create shell session into a new terminal window
let g:ScreenShellExternal = 1

" Height of the screenshell screen
let g:ScreenShellHeight = 16

" Set initial focus ('vim' or 'shell')
let g:ScreenShellInitialFocus = 'vim'
let g:ScreenShellTerminal = 'konsole'

let g:screenshell_commands = {
            \ 'erlang': 'erl',
            \ 'haskell': 'ghci -cpp',
            \ 'java': 'jshell',
            \ 'javascript': 'js52',
            \ 'julia': 'julia',
            \ 'matlab': '_matlab -nodesktop',
            \ 'ocaml': 'rlwrap ocaml',
            \ 'python': 'python',
            \ 'racket': 'racket',
            \ 'sml': 'rlwrap poly',
            \ }

nnoremap <silent> <C-c><C-x> :call aux#screenshell_quit()<cr>
nnoremap <silent> <C-c><C-c> :call aux#screenshell_call()<cr>
vnoremap <silent> <C-c><C-c> :call aux#screenshell_send()<cr>

"}}}

"{{{ RainbowParentheses

let g:rbpt_max = 16
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['red',         'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

augroup rainbow_parentheses
    autocmd!
    autocmd FileType lisp,racket RainbowParenthesesToggle
    autocmd FileType lisp,racket RainbowParenthesesLoadRound
    autocmd FileType lisp,racket RainbowParenthesesLoadSquare
augroup END

"}}}

"{{{ tcomment

let g:tcomment#rstrip_on_uncomment = 0
let g:tcomment_textobject_inlinecomment = 'Ic'

"}}}

"{{{ vimtex

let g:vimtex_complete_enabled = 0

"}}}

"{{{ python-syntax

let g:python_highlight_all = 1

"}}}

"{{{ vim-markdown

let g:vim_markdown_math = 1

"}}}

"{{{ auto-pairs

let g:AutoPairs = {
            \ '(':')',
            \ '[':']',
            \ '{':'}',
            \ "'":"'",
            \ '"':'"',
            \ '`':'`',
            \ }
let g:AutoPairsShortcutFastWrap = '<C-S-e>'

"}}}

"{{{ CtrlSF

let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_focus = {'at': 'start'}
let g:ctrlsf_selected_line_hl = 'p'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>N <Plug>CtrlSFVwordPath
vmap     <C-F>n <Plug>CtrlSFVwordExec
nmap     <C-F>N <Plug>CtrlSFCwordPath
nmap     <C-F>n <Plug>CtrlSFCwordExec
nmap     <C-F>C <Plug>CtrlSFCCwordPath
nmap     <C-F>c <Plug>CtrlSFCCwordExec
nmap     <C-F>P <Plug>CtrlSFPwordPath
nmap     <C-F>p <Plug>CtrlSFPwordExec
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

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
\       ],
\   },
\   'tabline': {
\       'left': [ [ 'tabs' ] ],
\       'right': [],
\   },
\ }

augroup lightline_settings
    autocmd!
    autocmd BufWinEnter * call aux#lightline#colours('green', 'yellow', 'red')
augroup END

"}}}

"{{{ UndoTree

nnoremap <F7> :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1

"}}}

"{{{ vim-tex-fold

let g:tex_fold_additional_envs = ['frontmatter']

"}}}

"{{{ vim-prosession

let g:prosession_on_startup = 1

"}}}

"{{{ ale

" Do not load ALE in vimdiff
if &diff
    let g:ale_enabled = 0
endif

let g:ale_linters = {
            \   'c': [],
            \   'cpp': [],
            \   'markdown': ['markdownlint', 'mdl', 'remark_lint'],
            \   'mediawiki': [],
            \   'python': ['pep8', 'flake8', 'pyre', 'mypy', 'bandit'],
            \   'tex': ['chktex'],
            \   'typescript': ['tslint', 'typecheck'],
            \ }

let s:text_linters = ['alex', 'proselint', 'redpen', 'vale', 'write-good']
let g:ale_extra_linters = {
            \   'tex': s:text_linters,
            \   'markdown': s:text_linters,
            \   'mediawiki': s:text_linters,
            \   'python': ['pylint', 'pycodestyle', 'pydocstyle'],
            \ }

let g:ale_lint_on_text_changed = 'normal' " 'never' to disable
let g:ale_lint_on_enter = 1

let g:ale_completion_enabled = 0
let g:ale_sign_error = 'EE'
let g:ale_sign_warning = 'WW'
let g:ale_sign_info = 'II'
let g:ale_sign_style_error = 'SE'
let g:ale_sign_style_warning = 'SW'
let g:ale_set_highlights = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%severity%] (%linter%) %[code] %%s'

nnoremap <leader>an <Plug>(ale_next_wrap)
nnoremap <leader>aN <Plug>(ale_previous_wrap)
nnoremap <leader>ag :ALEGoToDefinition<cr>
nnoremap <leader>ah :ALEHover<cr>
nnoremap <leader>as :ALESymbolSearch<cr>
nnoremap <leader>af <Plug>(ale_fix)

let g:ale_gitcommit_gitlint_options = '--config ~/.config/gitlint'
let g:ale_python_mypy_options = '-ignore-missing-imports'
let g:ale_alex_executable='alexjs'

" Toggle extra linters
command! ToggleExtraLinters call aux#toggle_extra_linters()

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

"}}}

"{{{ editorconfig-vim

let g:EditorConfig_exclude_patterns = [
            \ 'fugitive://.*',
            \ 'scp://.*',
            \ '.*/.git/.*',
            \ ]

"}}}

"{{{ vim-ccls

let g:ccls_close_on_jump = v:true

nnoremap <leader>,cc :CclsCallers<cr>
nnoremap <leader>,cC :CclsCallees<cr>
nnoremap <leader>,bb :CclsBaseHierarchy<cr>
nnoremap <leader>,dd :CclsDerivedHierarchy<cr>
nnoremap <leader>,mm :CclsMemberHierarchy<cr>

nnoremap <leader>,ch :CclsCallHierarchy<cr>
nnoremap <leader>,cH :CclsCalleeHierarchy<cr>
nnoremap <leader>,bh :CclsBaseHierarchy<cr>
nnoremap <leader>,dh :CclsDerivedHierarchy<cr>
nnoremap <leader>,mh :CclsMemberHierarchy<cr>

"}}}

"{{{ vim-unstack

let g:unstack_populate_quickfix = 1
let g:unstack_mapkey = '<leader>u'
nnoremap <silent> <F10> :UnstackFromClipboard<cr>

"}}}

"{{{ coc.nvim

" Do not load in vimdiff
if &diff
    let g:did_coc_loaded = 1
endif

call coc#add_extension(
\   'coc-json',
\   'coc-git',
\   'coc-lists',
\   'coc-omni',
\   'coc-snippets',
\   'coc-tsserver',
\   'coc-vimlsp',
\   )

let g:coc_user_config = {
\   'coc': {
\       'preferences': {
\           'codeLens': {
\               'enable': v:false,
\           },
\           'diagnostic': {
\               'displayByAle': v:true,
\           },
\           'timeout': 5000,
\           'noselect': v:true,
\           'previewAutoClose': v:false,
\       },
\   },
\   'suggest': {
\       'snippetIndicator': '►',
\   },
\   'git': {
\       'addedSign': {'hlGroup': 'GitGutterAdd'},
\       'changedSign': {'hlGroup': 'GitGutterChange'},
\       'removedSign': {'hlGroup': 'GitGutterDelete'},
\       'topRemovedSign': {'hlGroup': 'GitGutterDelete'},
\       'changeRemovedSign': {'hlGroup': 'GitGutterChangeDelete'},
\   },
\   'list': {
\       'limitLines': 30000,
\       'source': {
\           'files': {
\               'command': 'fd',
\               'args': ['--type', 'f', '--color=never'],
\           },
\       },
\   },
\   'languageserver': {
\       'ccls': {
\           'command': 'ccls',
\           'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
\           'rootPatterns': [
\               '.ccls',
\               'compile_commands.json',
\               '.git/',
\               '.hg/',
\           ],
\           'initializationOptions': {
\               'cache': {
\                   'directory': expand('~/.cache/ccls'),
\               }
\           }
\       },
\       'clangd': {
\           'command': 'clangd',
\           'filetypes': ['cuda'],
\           'rootPatterns': [
\               'compile_flags.txt',
\               'compile_commands.json',
\               '.git/',
\               '.hg/',
\           ],
\       },
\       'pyls': {
\           'command': 'pyls',
\           'filetypes': ['python'],
\       },
\       'jls': {
\           'command': 'jls',
\           'filetypes': ['julia'],
\       },
\       'haskell': {
\           'command': 'hie-wrapper',
\           'rootPatterns': ['.stack.yaml', 'cabal.config', 'package.yaml'],
\           'filetypes': ['hs', 'lhs', 'haskell'],
\       },
\       'bash': {
\           'args': ['start'],
\           'command': 'bash-language-server',
\           'filetypes': ['sh'],
\           'ignoredRootPaths': ['~'],
\       },
\       'latex': {
\           'command': 'java',
\           'args': ['-jar', '/usr/share/java/texlab/texlab.jar'],
\           'filetypes': ['tex', 'plaintex', 'contex'],
\       },
\       'groovy': {
\           'command': 'java',
\           'args': ['-jar', '/usr/share/java/groovy-language-server/groovy-language-server-all.jar'],
\           'filetypes': ['groovy'],
\       },
\       'r': {
\           'command': 'R',
\           'args': ['--slave', '-e', 'languageserver::run()'],
\           'filetypes': ['r'],
\       },
\   },
\ }

" Mappings
nmap <leader>,ca <plug>(coc-code-action)
vmap <leader>,ca <plug>(coc-code-action-selected)
nmap <leader>,cl <plug>(coc-codelens-action)
nmap <leader>,gD <plug>(coc-declaration)
nmap <leader>,gd <plug>(coc-definition)
nnoremap <leader>,h  :call CocActionAsync('doHover')<cr>
nmap <leader>,o  <plug>(coc-open-link)
nmap <leader>,e  <plug>(coc-diagnostic-next)
nmap <leader>,E  <plug>(coc-diagnostic-prev)
nmap <leader>,rf <plug>(coc-references)
nmap <leader>,r  <plug>(coc-rename)
nmap <leader>,f  <plug>(coc-fix-current)
nmap <leader>,df <plug>(coc-format)
vmap <leader>,df <plug>(coc-format-selected)
nmap <leader>,i  <plug>(coc-implementation)
nmap <leader>,td <plug>(coc-type-definition)

" Completion mappings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <c-j>   pumvisible() ? "\<C-y>" : ""
inoremap <expr> <cr>    pumvisible() ? "\<C-x><C-e><cr>" : "\<cr>"
inoremap <C-@> <C-x><C-o>

" Git mappings
nmap ]h <Plug>(coc-git-nextchunk)
nmap [h <Plug>(coc-git-prevchunk)
nmap <leader>gi <Plug>(coc-git-chunkinfo)

" List mappings
nnoremap <leader>. :CocList vimcommands<cr>
nnoremap <silent> <C-p> :CocList files<cr>

" Reference highlight
highlight link CocHighlightText CursorColumn
if ! &diff
    augroup coc_highlight
        autocmd!
        autocmd CursorHold * silent call aux#matchdelete('CocHighlightText') |
        \                           call CocActionAsync('highlight')
        autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
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
