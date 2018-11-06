"{{{ Fundamentals

" Leader
nmap <space> <nop>
let mapleader = " "
let g:mapleader = " "
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
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Encoding and file type
set encoding=utf8
set ffs=unix,dos,mac

" Doxygen highlighting
let g:doxygen_enhanced_color=1
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
autocmd FileType PKGBUILD set ft=sh

"}}}

"{{{ UI

" Wild menu completion
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*~,*.pyc

set ruler

set cmdheight=1 " Height of the command bar

set hid " Hide abandoned buffers

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
set mat=2 " Matching brackets blink duration

" Grep options
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Line numbers
set nu
highlight LineNr ctermfg=grey
set cursorline
hi CursorLine term=NONE cterm=NONE

"}}}

"{{{ Buffer

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Views
set viewdir=$HOME/.vim/views
set viewoptions-=options

" Read files after changes from outside
set autoread
" Trigger autoread
autocmd FocusGained,BufEnter * :silent! !

" Modeline settings
set nomodeline
set modelines=0

" Save file
nnoremap <Leader>w :w<CR>

" Detect filetype on save
autocmd BufWritePost * if &filetype == '' | filetype detect |  endif

" Number of commands in vim history
set history=5000

" Disable backups
set nobackup
set nowb
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
let g:tex_flavor = "latex"

" .cuh extension for CUDA headers
autocmd BufRead,BufNewFile *.cuh set filetype=cuda

" Jump to error from quickfix window with <cr>
autocmd FileType qf nmap <cr> :.ll<cr>:lclose<cr>

"}}}

"{{{ Indent

" Text width
set textwidth=500
autocmd FileType tex,markdown setlocal textwidth=79

" Set different text width inside comment regions
function SetCommentWidth(re)
    let l:winview = winsaveview()
    let l:region = synIDattr(synID(line("."), col("."), 0), "name")
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
set lbr

" Tab settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Short tab width for functional languages and some markup languages
autocmd FileType ocaml,sml,racket,haskell,yaml setlocal shiftwidth=2
autocmd FileType ocaml,sml,racket,haskell,yaml setlocal tabstop=2

" Don't expand tab in bash
autocmd FileType sh set noexpandtab

" Disable cindent (which removes Python comment indent)
autocmd FileType python set cindent

" tab lines without losing selection
vnoremap <s-tab> <gv
vnoremap <tab> >gv

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Pseudoindent wrapped lines
autocmd FileType tex :setlocal showbreak=\ \ \ \ |

" wrap lines in diff
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" Fold based on syntax
setlocal foldmethod=syntax " Careful, may be slow
autocmd Filetype vim setlocal foldmethod=marker
set foldlevel=99

" PHP settings
" enable html snippets in php files
autocmd BufRead,BufNewFile *.php set ft=php.html
" smartindent for php files
autocmd BufRead,BufNewFile *.php set smartindent
" don't align php tags at line beginning
autocmd FileType php.html setlocal indentexpr=

"}}}

"{{{ Motion

" Keep column when moving to first/last line
set nostartofline

set viminfo^=% " Remember info about open buffers on close

" Treat long lines as break lines
map j gj
map k gk

" Lines around the cursor
set scrolloff=7

" Keep current line in the middle of the window
autocmd CursorMoved,BufReadPost * exe "normal! zz"

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

" Camel case motion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
inoremap <C-w> <Esc>:normal db<Cr><Del>i
inoremap <C-k> <Esc>:normal ww<Cr>h:normal db<Cr>i

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
    set stal=2
catch
endtry

" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
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

" Delete trailing white space
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
command Trim :call DeleteTrailingWS()

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

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

let g:UltiSnipsExpandTrigger="<c-j>"
" force UltiSnips to use Python 2, for YCM compatibility
let g:UltiSnipsUsePythonVersion = 2
"let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-p>"
"let g:UltiSnipsListSnippets="<c-e>"

"}}}

"{{{ YouCompleteMe

" Completion shortcut
let g:ycm_key_invoke_completion = '<C-b>'

" Use ultisnips suggestions
let g:ycm_use_ultisnips_completer = 1

" Default (fallback) extra conf file
" let g:ycm_global_ycm_extra_conf = "~/Cryptbox/Configs/.ycm_extra_conf.py"

" Whitelist/blacklist for extra conf files
" let g:ycm_extra_conf_globlist = ['~/Dropbox/*', '~/Cryptbox/*']

" Disable preview on complete
set completeopt-=preview

" Completion keys
let g:ycm_key_list_previous_completion = ['<S-Tab>']
let g:ycm_key_list_select_completion = ['<Tab>']

" Goto declaration/definition
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g <silent> <leader><g
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g :YcmCompleter GoTo<cr>

" Pass diagnostic data to vim
let g:ycm_always_populate_location_list = 1

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
"
" map shortcut for import
autocmd FileType java nnoremap <leader>i <Esc>:JavaImport<cr>
" map shortcut to suggest a correction
autocmd FileType java nnoremap <leader>k :JavaCorrect<cr>
" override weird tab behaviour
autocmd FileType java silent inoremap <tab> <tab>

"}}}

"{{{ ConqueTerm

let g:ConqueTerm_StartMessages = 0

"}}}

"{{{ Screenshell

" Chose terminal multiplexer ("GnuScreen" or "Tmux")
let g:ScreenImpl = "GnuScreen"

" Create shell session into a new terminal window
let g:ScreenShellExternal = 1

" Height of the screenshell screen
let g:ScreenShellHeight = 16

" Set initial focus ("vim" or "shell")
let g:ScreenShellInitialFocus = "vim"
let g:ScreenShellTerminal = "konsole"

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
"    \ ['black',       'SeaGreen3'],
autocmd FileType lisp,racket RainbowParenthesesToggle
autocmd FileType lisp,racket RainbowParenthesesLoadRound
autocmd FileType lisp,racket RainbowParenthesesLoadSquare

"}}}

"{{{ neco-ghc

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
let g:haddock_browser="/usr/bin/chromium"

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

"{{{ Nerdcommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"}}}

"{{{ expand_region

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"}}}

"{{{ vim-go

set autowrite
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>:lclose<CR>

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
autocmd FileType tex let g:AutoPairs['$'] = '$'
let g:AutoPairsShortcutFastWrap = '<C-S-e>'

"}}}

"{{{ vim-gitgutter

autocmd FileType c,cpp,cuda,python let g:gitgutter_enabled = 0

"}}}

"{{{ CtrlP

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
let g:ctrlp_use_caching = 0
nnoremap è :CtrlPBuffer<cr>

"}}}

"{{{ CtrlSF

let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_focus = { "at": "start" }
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
let g:lldb_map_Ldetach = "<leader>Ld"
let g:lldb_map_Lrun = "<leader>Lr"
let g:lldb_map_Lstart = "<leader>LR"
let g:lldb_map_Lcontinue = "<leader>Lc"
let g:lldb_map_Lstep = "<leader>Ls"
let g:lldb_map_Lnext = "<leader>Ln"
let g:lldb_map_Lfinish = "<leader>Lf"
let g:lldb_map_Lbreakpoint = "<leader>Lb"
let g:lldb_map_Lprint = "<leader>Lp"
let g:lldb_map_Lpo = "<leader>Lo"
let g:lldb_map_LpO = "<leader>LO"

"}}}

"{{{ DetectSpellLang

map <leader>ss :setlocal spell!<cr>
autocmd FileType tex,markdown setlocal spell
autocmd FileType bib setlocal nospell
let g:guesslang_langs = [ 'en_GB', 'sv', 'it' ]

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
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" Insert breakpoint
autocmd FileType python nnoremap
            \ <leader>b <s-o>import pdb; pdb.set_trace()
            \  # XXX BREAKPOINT<esc>

"}}}

"{{{ ale

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
            \   '.*\.cp\{0,2\}$': {'ale_enabled': 0},
            \   '.*\.h[xp]\{0,2\}$': {'ale_enabled': 0},
            \}

let g:ale_python_flake8_options = '--ignore=W391,E501,E702,F403'

"}}}

