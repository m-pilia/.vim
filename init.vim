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
set undofile                        " Save undo's after file closes
set undodir=$HOME/.config/nvim/undo " where to save undo histories
set undolevels=1000                 " How many undos
set undoreload=10000                " number of lines to save for undo

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

"{{{ Highlighting

highlight link DiagnosticSignError SpellBad
highlight link DiagnosticSignWarn Todo
highlight link DiagnosticSignInfo Todo
highlight link DiagnosticSignHint Hint
highlight link DiagnosticVirtualTextError SpellBad
highlight link DiagnosticVirtualTextWarn Todo
highlight link DiagnosticVirtualTextInfo Todo
highlight link DiagnosticVirtualTextHint Hint

highlight link @lsp.type.class Type
highlight link @lsp.type.struct Type
highlight link @lsp.type.typeParameter Type
highlight link @lsp.type.comment Comment
highlight link @lsp.type.enumMember Normal
highlight link @lsp.type.function Function
highlight link @lsp.type.method Function
highlight link @lsp.type.macro Define
highlight link @lsp.type.namespace Normal
highlight link @lsp.type.parameter Normal
highlight link @lsp.type.variable Normal

"}}}

"{{{ Completion

inoremap <silent> <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <silent> <expr> <S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
inoremap <silent> <C-space> <C-n><C-p>
inoremap <silent> <expr> <C-j> pumvisible() ? "<C-y>" :"<C-j>"

"}}}

"{{{ LSP

nnoremap <silent> <C-s> :lua vim.lsp.buf.signature_help()<cr>

nnoremap <silent> <leader>,ca :lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> <leader>,gD :lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <leader>,gd :lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <leader>,h  :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>,rf :lua vim.lsp.buf.references()<cr>
nnoremap <silent> <leader>,r  :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>,f  :lua vim.lsp.buf.code_action({filter = function(a) return a.isPreferred end, apply = true})<cr>
nnoremap <silent> <leader>,df :lua vim.lsp.buf.format()<cr>
vnoremap <silent> <leader>,df :lua vim.lsp.buf.format()<cr>
nnoremap <silent> <leader>,i  :lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <leader>,td :lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> <leader>,ch :lua vim.lsp.buf.incoming_calls()<cr>
nnoremap <silent> <leader>,cH :lua vim.lsp.buf.outgoing_calls()<cr>
nnoremap <silent> <leader>,th :lua vim.lsp.buf.typehierarchy()<cr>

"}}}

" Source the lua config
if has('nvim')
    source $HOME/.config/nvim/luainit.lua
end

" Local customization point
if filereadable($HOME . '/.config/nvim/init.after.vim')
    source $HOME/.config/nvim/init.after.vim
end
