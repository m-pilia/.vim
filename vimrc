set encoding=utf-8
scriptencoding utf-8

" Leader
nmap <space> <nop>
let g:mapleader = ' '

"{{{ Colors

syntax enable

command! SyntaxRegionName echo synIDattr(synID(line('.'), col('.'), 0), 'name')

" Color scheme
colorscheme desert
set background=dark
highlight comment ctermfg=lightblue guifg=lightblue
highlight constant ctermfg=red guifg=red
highlight SpellBad ctermfg=white ctermbg=darkred guifg=white guibg=darkred
highlight SpellCap ctermfg=white ctermbg=brown guifg=white guibg=brown
highlight DiffAdd ctermbg=green ctermfg=black cterm=bold
highlight DiffChange ctermbg=229 ctermfg=black cterm=bold
highlight DiffDelete ctermbg=darkred ctermfg=white cterm=bold
highlight DiffText ctermbg=darkyellow ctermfg=white cterm=bold
highlight SignColumn ctermbg=black guibg=black
highlight GitGutterAdd ctermbg=black ctermfg=green guibg=black guifg=green
highlight GitGutterChange ctermbg=black ctermfg=yellow guibg=black guifg=yellow
highlight GitGutterDelete ctermbg=black ctermfg=red guibg=black guifg=red
highlight GitGutterChangeDelete ctermbg=black ctermfg=yellow guibg=black guifg=yellow
highlight link QuickFixLine Normal
highlight Pmenu ctermbg=238 ctermfg=grey guibg=#444444 ctermfg=grey
highlight LineNr ctermfg=grey guifg=grey
highlight CursorLine term=NONE cterm=NONE guibg=NONE
highlight link CocHighlightText CursorColumn
highlight CclsSkippedRegion ctermfg=darkgray guifg=darkgray
highlight link CocErrorSign SpellBad
highlight link CocWarningSign todo
highlight link CocInfoSign CocWarningSign
highlight CocHintSign ctermbg=green ctermfg=black guibg=green guifg=black
highlight link CocErrorHighlight CocErrorSign
highlight link CocWarningHighlight SpellCap
highlight link CocInfoHighlight SpellCap
highlight link CocHintHighlight CocHintSign
highlight conflictStart ctermbg=lightred ctermfg=black
highlight conflictMiddle ctermbg=lightblue ctermfg=black
highlight conflictEnd ctermbg=lightgreen cterm=bold ctermfg=black

" Text properties
if has('textprop')
    call prop_type_add('ccls_skipped_region', {'highlight': 'CclsSkippedRegion'})
endif

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

" Close all buffers except for the current one
command! Bo %bd | e# | bd#

" Diff options
set diffopt+=vertical

"}}}

"{{{ Indent

" Text width
set textwidth=2000

" Set different text width inside comment regions
augroup comment_width <buffer>
    autocmd!
    autocmd FileType c,cpp,cuda,java,python,vim
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

" Disable unconvenient keys
call aux#disable_keys(['Up', 'Down', 'Left', 'Right', 'Home', 'End', 'PageUp', 'PageDown'])

" CamelCase word backspace
imap <silent> <C-w> <C-O>:let save_ve = &virtualedit<cr>
    \<C-o>:setlocal virtualedit=all<cr>
    \<C-o>db
    \<C-o>:let &virtualedit = save_ve<cr>

" Search for visual selection
vnoremap <silent> * <esc>/\V<c-r>=escape(aux#visual_selection(), '/\')<cr><cr>
vnoremap <silent> # <esc>?\V<c-r>=escape(aux#visual_selection(), '/\')<cr><cr>

" Remove search highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh <bar> :CtrlSFClearHL<cr>

" Cycle through buffers
nnoremap <leader>g :b#<CR>
nnoremap <leader>f :bn<CR>
nnoremap <leader>F :bp<CR>
nnoremap <leader>b :ls<CR>:b<space>

" Cd to the directory of the open buffer
nnoremap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" Behavior when switching between buffers
set switchbuf=useopen

" Always show tab line
set showtabline=2

" Show help for the word under cursor
nnoremap <silent> <leader>h :help <c-r>=aux#vimhelp()<cr><cr>

" To match HTML tags with %
runtime macros/matchit.vim

" Tag navigation
set tagfunc=aux#tagfunc
nmap <silent> <leader>t <C-]>
nmap <silent> <leader>T g<C-]>

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

" Yank to system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d

" Put line
nnoremap <leader>p :put<cr>
nnoremap <leader>P :put!<cr>

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
nnoremap <silent> <leader>ga :call aux#accept_conflict()<cr>

"}}}

"{{{ netrw

nnoremap <silent> - :Explore<cr>

let g:netrw_fastbrowse = 0
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_hide = 1
let g:netrw_list_hide = aux#netrw_list_hide()

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

"{{{ Ultisnips

let g:UltiSnipsExpandTrigger = '<not_needed>'

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
            \ 'julia': 'julia -p auto',
            \ 'matlab': 'matlab -nodesktop',
            \ 'ocaml': 'rlwrap ocaml',
            \ 'python': 'python',
            \ 'racket': 'racket',
            \ 'sml': 'rlwrap poly',
            \ }

nnoremap <silent> <C-c><C-x> :call aux#screenshell_quit()<cr>
nnoremap <silent> <Leader>r :call aux#screenshell_call()<cr>
vnoremap <silent> <Leader>r :<C-u>call aux#screenshell_send()<cr>
command! -nargs=0 -range=% SS <line1>,<line2>ScreenSend

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
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1

"}}}

"{{{ auto-pairs

let g:AutoPairsShortcutFastWrap = '<C-S-e>'
let g:AutoPairsMultilineClose = v:false

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
    autocmd BufWinEnter * call aux#lightline#colours('green', 'yellow', 'red')
    autocmd User CocDiagnosticChange call lightline#update()
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

let g:EditorConfig_preserve_formatoptions = 1
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
\   'coc-yank',
\   )

let g:coc_user_config = {
\   'coc': {
\       'preferences': {
\           'codeLens': {
\               'enable': v:false,
\           },
\           'diagnostic': {
\               'messageTarget': 'echo',
\               'checkCurrentLine': v:true,
\               'errorSign': 'EE',
\               'warningSign': 'WW',
\               'infoSign': 'II',
\               'hintSign': 'HH',
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
\   'yank': {
\       'highlight': {'enable': v:false},
\       'enableCompletion': v:false,
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
\               },
\               'highlight': {
\                   'lsRanges': v:true,
\               },
\           },
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
\           'command': 'bash',
\           'args': ['-c', 'julia --startup-file=no --history-file=no -e "
\               using Pkg;
\               using LanguageServer;
\               import StaticLint;
\               import SymbolServer;
\               env_path = dirname(Pkg.Types.Context().env.project_file);
\               debug = false;
\               server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, \"\", Dict());
\               server.runlinter = true;
\               run(server);
\           "'],
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
\           'command': 'texlab',
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
\       'cmake': {
\           'command': 'cmake-language-server',
\           'filetypes': ['cmake'],
\           'rootPatterns': ['build/'],
\           'initializationOptions': {
\               'buildDirectory': 'build',
\           },
\       },
\       'dls': {
\           'command': 'diagnostic-languageserver',
\           'args': ['--stdio'],
\           'filetypes': [
\               'ada',
\               'awk',
\               'bib',
\               'cmake',
\               'dockerfile',
\               'gitcommit',
\               'ispc',
\               'make',
\               'matlab',
\               'pkgbuild',
\               'python',
\               'qml',
\               'sh',
\               'tex',
\               'vim',
\           ],
\           'initializationOptions': {
\               'linters': aux#diagnostic#linters(),
\               'filetypes': {
\                   'ada': 'gcc-ada',
\                   'awk': 'gawk',
\                   'bib': 'bibclean',
\                   'cmake': 'cmakelint',
\                   'dockerfile': 'hadolint',
\                   'gitcommit': ['gitlint', 'languagetool'],
\                   'ispc': 'ispc',
\                   'make': 'checkmake',
\                   'matlab': 'mlint',
\                   'pkgbuild': 'shellcheck_pkgbuild',
\                   'python': 'bandit',
\                   'qml': 'qmllint',
\                   'sh': 'shellcheck',
\                   'tex': 'chktex',
\                   'vim': 'vint',
\               },
\           },
\       },
\   },
\ }

" Mappings
nmap <silent> <leader>,ca <plug>(coc-code-action)
vmap <silent> <leader>,ca <plug>(coc-code-action-selected)
nmap <silent> <leader>,cl <plug>(coc-codelens-action)
nmap <silent> <leader>,gD <plug>(coc-declaration)
nmap <silent> <leader>,gd <plug>(coc-definition)
nnoremap <silent> <leader>,h  :call CocActionAsync('doHover')<cr>
nmap <silent> <leader>,o  <plug>(coc-open-link)
nmap <silent> <leader>,e  <plug>(coc-diagnostic-next)
nmap <silent> <leader>,E  <plug>(coc-diagnostic-prev)
nmap <silent> <leader>,rf <plug>(coc-references)
nmap <silent> <leader>,r  <plug>(coc-rename)
nmap <silent> <leader>,f  <plug>(coc-fix-current)
nmap <silent> <leader>,df <plug>(coc-format)
vmap <silent> <leader>,df <plug>(coc-format-selected)
nmap <silent> <leader>,i  <plug>(coc-implementation)
nmap <silent> <leader>,td <plug>(coc-type-definition)

" Scroll float window
nnoremap <expr> <C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr> <C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Completion mappings
inoremap <silent> <expr> <plug>(smart_tab) pumvisible() ? "\<C-n>" : "\<Tab>"
imap <silent> <Tab> <plug>(smart_tab)
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <c-j> aux#pum_noselect() ? "\<C-y>" : "<C-R>=UltiSnips#ExpandSnippetOrJump()<cr>"
snoremap <silent> <c-j> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
xnoremap <silent> <c-j> :call UltiSnips#SaveLastVisualSelection()<cr>gvs
inoremap <silent> <expr> <c-space> coc#refresh()

" Git mappings
nmap <silent> ]h <Plug>(coc-git-nextchunk)
nmap <silent> [h <Plug>(coc-git-prevchunk)
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
nmap <silent> <leader>gu :CocCommand git.chunkUndo<cr>
nmap <silent> <leader>gs :CocCommand git.chunkStage<cr>
omap ih <Plug>(coc-text-object-inner)
xmap ih <Plug>(coc-text-object-inner)
omap ah <Plug>(coc-text-object-outer)
xmap ah <Plug>(coc-text-object-outer)

" List mappings
nnoremap <leader>. :CocList vimcommands<cr>
nnoremap <silent> <C-p> :CocList files<cr>
nnoremap <silent> <C-k> :CocList buffers<cr>
nnoremap <silent> <C-j> :CocList yank<cr>

" Reference highlight
if ! &diff
    augroup coc_highlight
        autocmd!
        autocmd CursorHold * silent call aux#matchdelete('CocHighlightText') |
        \                           call CocActionAsync('highlight')
        autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
        autocmd User CocNvimInit call CocRegistNotification('ccls',
        \                                                   '$ccls/publishSkippedRanges',
        \                                                   function('aux#skipped_regions'))
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

let g:vim_mediawiki_browser_command = "chromium \r"
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
