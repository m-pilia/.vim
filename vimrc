
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
            \ 'complete_parentheses',
            \ 'toggle_comments',
            \ 'python-mode',
            \ ]
call pathogen#infect()

" tex file flavor
let g:tex_flavor = "latex"

" .cuh extension for CUDA headers
autocmd BufRead,BufNewFile *.cuh set filetype=cuda


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set to auto read when a file is changed from the outside
set autoread
" Trigger autoread when changing buffers or coming back to vim.
autocmd FocusGained,BufEnter * :silent! !

syntax enable " Enable syntax highlighting

" Color scheme
colorscheme desert
set background=dark
highlight comment ctermfg=lightblue
highlight constant ctermfg=red

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8 " Set utf8 as standard encoding
set ffs=unix,dos,mac " Use Unix as the standard file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set so=7 " Set 7 lines to the cursor - when moving vertically using j/k

" Wild menu completion
set wildmenu
set wildmode=longest:full
set wildignore=*.o,*~,*.pyc

set ruler " Always show current position

set cmdheight=1 " Height of the command bar

set hid " A buffer becomes hidden when it is abandoned

set backspace=eol,start,indent " Configure backspace so it acts as it should

set whichwrap+=<,>,h,l,[,] " Configure keys to move next/previous line

" Search options
set ignorecase
set smartcase
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set magic " For regular expressions turn magic on

set lazyredraw " Don't redraw while executing macros (for performance)

set showmatch " Show matching brackets when text indicator is over them
set mat=2 " How many tenths of a second to blink when matching brackets

" remove search highlighting with <f6>
inoremap <F6> <esc>:let @/ = ""<cr>i
nnoremap <F6> :let @/ = ""<cr>

" grep options
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Line numbers
set nu
highlight LineNr ctermfg=grey
set cursorline
hi CursorLine term=NONE cterm=NONE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" save file
nnoremap <Leader>w :w<CR>

" detect filetype on save
autocmd BufWritePost * if &filetype == '' | filetype detect |  endif

set history=2000 " Sets how many lines of history VIM has to remember

" Turn backup off
set nobackup
set nowb
set noswapfile

" undo tree plugin
nnoremap <F7> :UndotreeToggle<cr>
inoremap <F7> <Esc>:UndotreeToggle<cr>

" persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" disable persistent undo on some files
autocmd BufNewFile,BufRead * call PersistentUndo()
function PersistentUndo()
    let file_name = expand('%:p')
    let file_name_esc = substitute(file_name, "%", "%%", "g")
    let file_name_esc = substitute(file_name_esc, "/", "%", "g")
    " exclude some directories, or files with too long names
    if match(expand('%:p'), '^/tmp') != -1  ||
     \ strlen(file_name_esc) > 75
        setlocal noundofile
        echo 'Warning: undo file not in use'
    endif
endfunction

" time between automatic updates
set updatetime=200

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" line length
autocmd FileType tex,markdown set textwidth=79

" tab settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" short tab width for functional languages and some markup languages
autocmd FileType ocaml,sml,racket,haskell,yaml setlocal shiftwidth=2
autocmd FileType ocaml,sml,racket,haskell,yaml setlocal tabstop=2

" don't expand tab in bash
autocmd FileType sh set noexpandtab

" disable cindent (which removes Python comment indent)
autocmd FileType python set cindent

" tab lines without losing selection
vnoremap <s-tab> <gv
vnoremap <tab> >gv

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" pseudoindent wrapped lines
autocmd FileType tex :set showbreak=\ \ \ \ 

" fold based on syntax
set foldmethod=syntax
set nofoldenable
set foldlevel=99


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nostartofline " keep column when moving to first/last line

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set viminfo^=% " Remember info about open buffers on close

" Treat long lines as break lines
map j gj
map k gk

" Keep current line in the middle of the window
autocmd CursorMoved,BufReadPost * exe "normal! zz"

" Enable mouse interaction
"set mouse=a

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

" camel case motion
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

" shortcuts for <home> and <end>
nmap <leader>h <Home>
nmap <leader>l <End>
vmap <leader>h <Home>
vmap <leader>l <End>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" <leader>l       : list buffers
" <leader>b <leader>f <leader>s : go back/forward/last-used
" <leader>1 <leader>2 <leader>3 : go to buffer 1/2/3 etc
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>s :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" nnoremap <Leader>l :ls<CR>

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" navigate windows with alt+arrow
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" move between tabs
" (use `sed -n l` to check how input is mapped into terminal)
imap <Esc>[1;3C <esc>:tabprevious<cr>
vmap <Esc>[1;3C <esc>:tabprevious<cr>
map <Esc>[1;3C :tabprevious<cr>
imap <Esc>[1;3D <esc>:tabnext<cr>
vmap <Esc>[1;3D <esc>:tabnext<cr>
nmap <Esc>[1;3D :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Don't close window, when deleting a buffer
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

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"  <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" spellcheck on some file formats
autocmd FileType tex,markdown set spell
autocmd FileType bib set nospell

" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" doxygen highlighting
let g:doxygen_enhanced_color=1
autocmd FileType c :set syntax=c.doxygen
autocmd FileType cpp :set syntax=cpp.doxygen
autocmd FileType java :set syntax=java.doxygen
autocmd FileType idl :set syntax=idl.doxygen
autocmd FileType php :set syntax=php.doxygen

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
augroup CommentWidth
    autocmd!
    autocmd FileType c,cpp,cuda,java,python autocmd CursorMoved,CursorMovedI *
                \ :call SetCommentWidth('\v(Comment|doxygen)')
augroup END

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
" force UltiSnips to use Python 2, for YCM compatibility
let g:UltiSnipsUsePythonVersion = 2
"let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-p>"
"let g:UltiSnipsListSnippets="<c-e>"

" YouCompleteMe
" completion shortcut
"let g:ycm_key_invoke_completion = '<C-b>'
" use ultisnips suggestions
let g:ycm_use_ultisnips_completer = 1
" default (fallback) extra conf file
" let g:ycm_global_ycm_extra_conf = "~/Cryptbox/Configs/.ycm_extra_conf.py"
" whitelist/blacklist for extra conf files
" let g:ycm_extra_conf_globlist = ['~/Dropbox/*', '~/Cryptbox/*']
" disable preview on complete
set completeopt-=preview
" completion keys
let g:ycm_key_list_previous_completion = ['<S-Tab>']
let g:ycm_key_list_select_completion = ['<Tab>']
" goto declaration/definition
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g <silent> <leader><g
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><g :YcmCompleter GoTo<cr>
" pass diagnostic data to vim
let g:ycm_always_populate_location_list = 1
" goto next/prev warning/error
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><n :lnext<cr>
autocmd FileType c,cpp,python,cs,objc,objcpp nnoremap <leader><N :lprevious<cr>
" commands
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

" omni completion
set omnifunc=syntaxcomplete#Complete

" " omni completion function for java completion plugin (conflicts with eclim)
" autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" ListToggle
let g:lt_location_list_toggle_map = '<leader><l'
let g:lt_quickfix_list_toggle_map = '<leader><q'
let g:lt_height = 10

" eclim
let g:EclimCompletionMethod = 'omnifunc'
" launch eclim when opening a java file, only when it is not running yet
autocmd FileType java silent !if [[ `ps x | grep 'org\.eclim\.application' | grep -v 'grep'` == '' ]]; then /usr/lib/eclipse/eclimd > /dev/null & fi
" create eclim project if absent when opening file
"autocmd FileType java silent :call eclimproject#CreateEclimProject()
" map shortcut for import
autocmd FileType java nnoremap <leader>i <Esc>:JavaImport<cr>
" map shortcut to suggest a correction
autocmd FileType java nnoremap <leader>k :JavaCorrect<cr>
" override weird tab behaviour
autocmd FileType java silent inoremap <tab> <tab>

" PHP
" enable html snippets in php files
autocmd BufRead,BufNewFile *.php set ft=php.html
" smartindent for php files
autocmd BufRead,BufNewFile *.php set smartindent
" don't align php tags at line beginning
autocmd FileType php.html setlocal indentexpr=

" camel case backspace
let g:camelbackspaceTrigger = ''

" disable ConqueTerm warnings
let g:ConqueTerm_StartMessages = 0

" screenshell settings
" chose terminal multiplexer ("GnuScreen" or "Tmux")
let g:ScreenImpl = "GnuScreen"
" create shell session into a new terminal window
let g:ScreenShellExternal = 1
" height of the screenshell screen
let g:ScreenShellHeight = 16
" set initial focus ("vim" or "shell")
let g:ScreenShellInitialFocus = "vim"
let g:ScreenShellTerminal = "konsole"

" color parentheses in lisp languages
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

" syntax highlighting synchronization settings
" see http://vimdoc.sourceforge.net/htmldoc/syntax.html#:syn-sync
" sync file from start (NOTE: slow but very precise)
autocmd BufEnter * :syntax sync fromstart
" get rid of C comment problems
"autocmd BufEnter * :syntax sync ccomment

" neco-ghc
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
let g:haddock_browser="/usr/bin/chromium"

" ghc-mod
map <silent> tw :w<cr>:GhcModTypeInsert<CR>
map <silent> ts :w<cr>:GhcModSplitFunCase<CR>
map <silent> tq :w<cr>:GhcModType<CR>
map <silent> te :w<cr>:GhcModTypeClear<CR>

" haskell syntax highlight
let hs_highlight_boolean = 1
let hs_highlight_debug = 1

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`

" tabularize
let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" nerdcommenter
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

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vim-go
set autowrite
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>:lclose<CR>

" NERDTree
nnoremap <Leader>- :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" delete the buffer of a file just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" quit when opening a file
let NERDTreeQuitOnOpen = 1

" lh-brackets
let g:usemarks = 0

" wrap lines in diff
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" vimtex
let g:vimtex_complete_recursive_bib = 1

" python-syntax extension
let g:python_highlight_all = 1

" PKGBUILD syntax highlighting is horrible
autocmd FileType PKGBUILD set ft=sh

" python-mode
let g:pymode_rope_completion = 0 " disable completion
let g:pymode_syntax = 0 " disable syntax highlighting
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_sort = ['E', 'C', 'I']
let g:pymode_lint_ignore = ["W391", "E501"]

" vim-markdown
let g:vim_markdown_math = 1
" autocmd FileType markdown set conceallevel=2

" auto-pairs
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

" vim-gitgutter
autocmd FileType c,cpp,cuda,python let g:gitgutter_enabled = 0

" CtrlSF
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

" vim-multiple-cursors
let g:multi_cursor_start_key = '<Esc>n'
let g:multi_cursor_select_all_key = 'g<Esc>n'
let g:ctrlsf_default_view_mode = 'compact'
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

" fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
