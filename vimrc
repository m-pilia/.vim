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
let g:pathogen_disabled = [
            \ 'restore_view',
            \ 'complete_parentheses',
            \ 'toggle_comments',
            \ ]
call pathogen#infect()

"}}}

"{{{ Colors

syntax enable " Enable syntax highlighting
command! SyntaxRegionName echo synIDattr(synID(line("."), col("."), 0), "name")

" Color scheme
colorscheme desert
set background=dark
highlight comment ctermfg=lightblue
highlight constant ctermfg=red
highlight SpellBad ctermfg=white ctermbg=darkred guifg=white guibg=darkred
highlight SpellCap ctermfg=white ctermbg=brown guifg=white guibg=brown

" GUI options
if has('gui_running')
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Encoding and file type
set encoding=utf8
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

    " PKGBUILD syntax highlighting is horrible
    autocmd FileType PKGBUILD setlocal ft=sh
augroup END

"}}}

"{{{ UI

" Wild menu completion
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*~,*.pyc

set ruler

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
highlight LineNr ctermfg=grey
set cursorline
hi CursorLine term=NONE cterm=NONE

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

    " Jump to error from quickfix window with <cr>
    autocmd FileType qf nmap <buffer> <cr> :.ll<cr>:lclose<cr>
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
let g:auto_persistent_undo = 0

" time (ms) between automatic updates
set updatetime=200

" Tex file flavor
let g:tex_flavor = 'latex'

"}}}

"{{{ Indent

" Text width
set textwidth=2000

" Set different text width inside comment regions
function SetCommentWidth(re)
    let l:winview = winsaveview()
    let l:region = synIDattr(synID(line('.'), col('.'), 0), 'name')
    if match(region, a:re) >= 0
        setlocal textwidth=72
    else
        setlocal textwidth=120
    endif
    call winrestview(l:winview)
endfunction
augroup CommentWidth <buffer>
    autocmd!
    autocmd FileType c,cpp,cuda,java,python
                \ autocmd CursorMoved,CursorMovedI <buffer>
                \ :call SetCommentWidth('\v(Comment|doxygen)')
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
setlocal foldmethod=syntax " Careful, may be slow

augroup indentation
    autocmd!

    " Text width
    autocmd FileType tex,markdown setlocal textwidth=79

    " Short tab width for functional languages and some markup languages
    autocmd FileType ocaml,sml,racket,haskell,yaml setlocal shiftwidth=2
    autocmd FileType ocaml,sml,racket,haskell,yaml setlocal tabstop=2

    " Don't expand tab in bash
    autocmd FileType sh setlocal noexpandtab

    " Disable cindent (which removes Python comment indent)
    autocmd FileType python set cindent

    " Pseudoindent wrapped lines
    autocmd FileType tex :setlocal showbreak=\ \ \ \ |

    " Wrap lines in diff
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif

    " Fold for viml
    autocmd Filetype vim setlocal foldmethod=marker

    " PHP settings
    " enable html snippets in php files
    autocmd BufRead,BufNewFile *.php set ft=php.html
    " smartindent for php files
    autocmd BufRead,BufNewFile *.php set smartindent
    " don't align php tags at line beginning
    autocmd FileType php.html setlocal indentexpr=
augroup END

"}}}

"{{{ Motion

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

" CamelCase word backspace
imap <silent> <C-w> <C-o>:set virtualedit+=onemore<cr><C-o>db<C-o>:set virtualedit-=onemore<cr>

" Shortcuts for <home> and <end>
nmap <leader>h <Home>
nmap <leader>l <End>
vmap <leader>h <Home>
vmap <leader>l <End>

" Remove search highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr> <bar> :CtrlSFClearHL<cr>

" Cycle through buffers
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>F :bp<CR>

" Navigate windows with arrows
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>

" Move between tabs
" (use `sed -n l` to check how input is mapped into terminal)
imap <Esc>[1;3C <esc>:tabprevious<cr>
vmap <Esc>[1;3C <esc>:tabprevious<cr>
map <Esc>[1;3C :tabprevious<cr>
imap <Esc>[1;3D <esc>:tabnext<cr>
vmap <Esc>[1;3D <esc>:tabnext<cr>
nmap <Esc>[1;3D :tabnext<cr>

" Open a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set showtabline=2
catch
endtry

" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr('%')
    let l:alternateBufNum = bufnr('#')

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr('%') == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute('bdelete! '.l:currentBufNum)
    endif
endfunction

"}}}

"{{{ Legacy status line

" Always show the status line
set laststatus=2

" colours for status line
hi User1 ctermfg=darkgrey ctermbg=grey
hi User2 ctermfg=darkgrey ctermbg=grey
hi User3 ctermfg=darkmagenta ctermbg=grey
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
function AutoPaste()
    let nopaste = 0
	if (!&paste)
		set paste
        let nopaste = 1
    endif
    normal! "+p
	if nopaste
		set nopaste
    endif
endfunction
inoremap <C-v>	<space><backspace><Esc>:call AutoPaste()<cr>a

" F5 in insert mode
imap <F5> <esc><F5>

"}}}

""""""""""""""""""" Plugin settings

"{{{ Ultisnips

let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsUsePythonVersion = 2 " YCM compatibility

"}}}

"{{{ YouCompleteMe

" Use ultisnips suggestions
let g:ycm_use_ultisnips_completer = 1

" Disable preview on complete
set completeopt-=preview

" Completion keys
let g:ycm_key_list_previous_completion = ['<S-Tab>']
let g:ycm_key_list_select_completion = ['<Tab>']

" Pass diagnostic data to vim
let g:ycm_always_populate_location_list = 1

augroup ycm
    autocmd!

    " Goto declaration/definition
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g <silent> <leader><g
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g :YcmCompleter GoTo<cr>

    " Goto next/prev warning/error
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><n :lnext<cr>
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><N :lprevious<cr>

    " Commands
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><f :YcmCompleter FixIt<cr>
    autocmd FileType cs,objc,objcpp nnoremap <leader><r :YcmCompleter RefactorRename
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><d :YcmCompleter GetDoc<cr>
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><p :YcmCompleter GetParent<cr>
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><t :YcmCompleter GetType<cr>
    autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><e :YcmShowDetailedDiagnostic<cr>
augroup END

" File type blacklist
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ }
let g:ycm_semantic_triggers = {
      \ 'haskell' : ['.'],
      \ }
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" Omni completion
set omnifunc=syntaxcomplete#Complete

" Omni completion function for java completion plugin (conflicts with eclim)
" autocmd Filetype java setlocal omnifunc=javacomplete#Complete

"}}}

"{{{ ListToggle

let g:lt_location_list_toggle_map = '<leader><l'
let g:lt_quickfix_list_toggle_map = '<leader><q'
let g:lt_height = 10

"}}}

"{{{ Eclim

let g:EclimCompletionMethod = 'omnifunc'

" Launch eclim when opening a java file, only when it is not running yet
" autocmd FileType java silent !if [[ `ps x | grep 'org\.eclim\.application' | grep -v 'grep'` == '' ]]; then /usr/lib/eclipse/eclimd > /dev/null & fi

" Create eclim project if absent when opening file
"autocmd FileType java silent :call eclimproject#CreateEclimProject()

augroup eclim
    autocmd!

    " map shortcut for import
    autocmd FileType java nnoremap <leader>i <Esc>:JavaImport<cr>
    " map shortcut to suggest a correction
    autocmd FileType java nnoremap <leader>k :JavaCorrect<cr>
    " override weird tab behaviour
    autocmd FileType java silent inoremap <tab> <tab>
augroup END

"}}}

"{{{ ConqueTerm

let g:ConqueTerm_StartMessages = 0

"}}}

"{{{ Screenshell

" Chose terminal multiplexer ('GnuScreen' or 'Tmux')
let g:ScreenImpl = 'GnuScreen'

" Create shell session into a new terminal window
let g:ScreenShellExternal = 1

" Height of the screenshell screen
let g:ScreenShellHeight = 16

" Set initial focus ('vim' or 'shell')
let g:ScreenShellInitialFocus = 'vim'
let g:ScreenShellTerminal = 'konsole'

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

"{{{ neco-ghc

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
let g:haddock_browser='/usr/bin/chromium'

augroup neco_ghc
    autocmd!
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

"}}}

"{{{ ghc-mod

map <silent> tw :w<cr>:GhcModTypeInsert<CR>
map <silent> ts :w<cr>:GhcModSplitFunCase<CR>
map <silent> tq :w<cr>:GhcModType<CR>
map <silent> te :w<cr>:GhcModTypeClear<CR>

"}}}

"{{{ haskell-vim

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`

" haskell syntax highlight
let hs_highlight_boolean = 1
let hs_highlight_debug = 1

"}}}

"{{{ tabularize

let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

"}}}

"{{{ tcomment

let g:tcomment#rstrip_on_uncomment = 0

"}}}

"{{{ expand_region

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
            \ 'iw' : 0,
            \ 'iW' : 0,
            \ 'i"' : 0,
            \ 'i''': 0,
            \ 'i]' : 1,
            \ 'ib' : 1,
            \ 'iB' : 1,
            \ 'il' : 1,
            \ 'ip' : 0,
            \ 'ie' : 0,
            \ }

call expand_region#custom_text_objects({
            \ 'ac': 1,
            \ 'ic': 1,
            \ 'af': 1,
            \ 'if': 1,
            \ })

"}}}

"{{{ vim-go

set autowrite
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>:lclose<CR>

augroup vim_go
    autocmd!
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
augroup END

"}}}

"{{{ NERDTree

nnoremap <Leader>- :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Delete the buffer of a file just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Quit when opening a file
let NERDTreeQuitOnOpen = 1

"}}}

"{{{ vimtex

let g:vimtex_complete_recursive_bib = 1

"}}}

"{{{ python-syntax

let g:python_highlight_all = 1

"}}}

"{{{ vim-markdown

let g:vim_markdown_math = 1
" autocmd FileType markdown set conceallevel=2

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

"{{{ vim-gitgutter

highlight GitGutterAdd ctermbg=black ctermfg=green
highlight GitGutterChange ctermbg=black ctermfg=yellow
highlight GitGutterDelete ctermbg=black ctermfg=red
highlight GitGutterChangeDelete ctermbg=black ctermfg=yellow
nmap <leader>hn <Plug>GitGutterNextHunk
nmap <leader>hN <Plug>GitGutterPrevHunk

augroup gitgutter
    autocmd!
    autocmd FileType c,cpp,cuda,python let g:gitgutter_enabled = 0
augroup END

"}}}

"{{{ CtrlP

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
let g:ctrlp_use_caching = 0
let g:ctrlp_mruf_relative = 1

"}}}

"{{{ CtrlSF

let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_focus = { 'at': 'start' }
let g:ctrlsf_selected_line_hl = 'op'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"}}}

"{{{ vim-multiple-cursors

let g:multi_cursor_start_key = '<Esc>n'
let g:multi_cursor_select_all_key = 'g<Esc>n'
let g:ctrlsf_default_view_mode = 'compact'
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

"}}}

"{{{ fzf

" Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
inoremap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <c-x><c-j> <plug>(fzf-complete-file-ag)
inoremap <c-x><c-l> <plug>(fzf-complete-line)
" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"}}}

"{{{ Gutentags

let g:gutentags_cache_dir = '~/.cache/tags'
let g:gutentags_trace = 0
let g:gutentags_generate_on_empty_buffer = 1

" Tag search
nnoremap <leader>T :Tags<cr>
nmap <leader>t <c-]>

"}}}

"{{{ lightline

set noshowmode
let g:lightline = {'colorscheme': 'wombat'}

let g:lightline.component_function = {
            \ 'gitbranch': 'fugitive#head',
            \ }

let g:lightline.component = {
            \ 'lineinfo': '%l/%L:%-v',
            \ 'filename': '%<%f %m',
            \ }

let g:lightline.tab_component = {
            \ 'filename': '%f %m',
            \ }

let g:lightline.active = {
            \ 'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'gitbranch', 'readonly', 'filename' ],
            \ ],
            \ 'right': [
            \     [ 'percent' ],
            \     [ 'lineinfo' ],
            \     [ 'fileformat', 'fileencoding', 'filetype' ],
            \ ],
            \ }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [],
            \ }

"}}}

"{{{ vebugger

let g:vebugger_leader='<leader>V'
nnoremap <leader>Vk :VBGkill<cr>
nnoremap <leader>VG :VBGstartGDB |
nnoremap <leader>VL :VBGstartLLDB |
nnoremap <leader>VJ :VBGstartJDB |
nnoremap <leader>VR :VBGstartRDB |
nnoremap <leader>VP :VBGstartPDB |
nnoremap <leader>VM :VBGstartMDBG |

"}}}

"{{{ lldb

nnoremap <leader>Lh :Lhide
nnoremap <leader>LH :Lshow
nnoremap <leader>La :Lattach
nnoremap <leader>Lt :Ltarget
let g:lldb_map_Ldetach = '<leader>Ld'
let g:lldb_map_Lrun = '<leader>Lr'
let g:lldb_map_Lstart = '<leader>LR'
let g:lldb_map_Lcontinue = '<leader>Lc'
let g:lldb_map_Lstep = '<leader>Ls'
let g:lldb_map_Lnext = '<leader>Ln'
let g:lldb_map_Lfinish = '<leader>Lf'
let g:lldb_map_Lbreakpoint = '<leader>Lb'
let g:lldb_map_Lprint = '<leader>Lp'
let g:lldb_map_Lpo = '<leader>Lo'
let g:lldb_map_LpO = '<leader>LO'

"}}}

"{{{ DetectSpellLang

map <leader>ss :setlocal spell!<cr>
let g:guesslang_langs = [ 'en_GB', 'sv', 'it' ]

augroup detect_spell_lang
    autocmd!
    autocmd FileType tex,markdown,mediawiki setlocal spell
    autocmd FileType bib setlocal nospell
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

"{{{ jedi-vim

let g:jedi#completions_enabled = 0
let g:jedi#goto_command = '<leader>d'
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#goto_definitions_command = ''
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<leader>n'
let g:jedi#completions_command = '<C-Space>'
let g:jedi#rename_command = '<leader>r'

" Insert breakpoint

augroup jedi_vim
    autocmd!
    autocmd FileType python nnoremap
                \ <leader>b <s-o>import pdb; pdb.set_trace()
                \  # XXX BREAKPOINT<esc>
augroup END

"}}}

"{{{ ale

let g:ale_linters = {
            \   'tex': ['chktex'],
            \   'markdown': ['markdownlint', 'mdl', 'remark_lint'],
            \   'mediawiki': [],
            \   'python': ['pep8', 'flake8', 'pyre', 'mypy', 'bandit'],
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

let g:ale_pattern_options = {
            \ '\v.*\.(c|(cpp)|h|(hpp)|(hxx)|(inl)|(cu)|(cuh))$': {'ale_enabled': 0},
            \ }

let g:ale_gitcommit_gitlint_options = '--config ~/.config/gitlint'
let g:ale_python_mypy_options = '-ignore-missing-imports'
let g:ale_alex_executable='alexjs'

" Toggle extra linters
function! ToggleExtraLinters()
    if !has_key(g:ale_extra_linters, &filetype)
        return
    endif
    for linter in g:ale_extra_linters[&filetype]
        let l:i = index(g:ale_linters[&filetype], linter)
        if l:i >= 0
            call remove(g:ale_linters[&filetype], l:i)
        else
            call add(g:ale_linters[&filetype], linter)
        endif
    endfor
endfunction

command! ToggleExtraLinters call ToggleExtraLinters()

"}}}

"{{{ vim-wordmotion

" Do not use wordmotion in visual selection (for vim-expand-region)
let g:wordmotion_mappings = {
            \ 'w' : 'w',
            \ 'b' : 'b',
            \ 'e' : 'e',
            \ 'ge' : 'ge',
            \ 'aw' : 'a<M-w>',
            \ 'iw' : 'i<M-w>',
            \ '<C-R><C-W>' : '<C-R><C-W>'
            \ }

"}}}

"{{{ vim-better-whitespace

let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help']
let g:show_spaces_that_precede_tabs = 1

"}}}


"{{{ editorconfig-vim

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"}}}
