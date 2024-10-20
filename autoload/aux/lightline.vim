scriptencoding utf-8

function! aux#lightline#has_hunks() abort
    let [l:a, l:c, l:d] = GitGutterGetHunkSummary()
    return (l:a + l:c + l:d) > 0
endfunction

function! aux#lightline#git_added() abort
    let [l:a, l:c, l:d] = GitGutterGetHunkSummary()
    return l:a > 0 ? printf('+%d', l:a) : ''
endfunction

function! aux#lightline#git_changed() abort
    let [l:a, l:c, l:d] = GitGutterGetHunkSummary()
    return l:c > 0 ? printf('~%d', l:c) : ''
endfunction

function! aux#lightline#git_deleted() abort
    let [l:a, l:c, l:d] = GitGutterGetHunkSummary()
    return l:d > 0 ? printf('-%d', l:d) : ''
endfunction

" Update the highlight groups for the git status
" Use in autocmd if the lightline theme has different colours for different modes
function! aux#lightline#colours() abort
    let l:map = {
    \   'n': 'normal',
    \   'i': 'insert',
    \   'v': 'visual',
    \   'r': 'replace',
    \ }
    let l:mode = get(l:map, tolower(mode()[0]), 'normal')
    let l:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
    let l:palette = l:palette[l:mode]['left'][1]
    let [l:termbg, l:guibg] = [l:palette[3], l:palette[1]]
    exec 'highlight GitStatusLineAdd '
    \               'ctermbg=' . l:termbg . ' ctermfg=Green' .
    \               ' guibg=' . l:guibg . ' guifg=#54ff54'
    exec 'highlight GitStatusLineChange '
    \               'ctermbg=' . l:termbg . ' ctermfg=Yellow' .
    \               ' guibg=' . l:guibg . ' guifg=#ffff54'
    exec 'highlight GitStatusLineDelete '
    \               'ctermbg=' . l:termbg . ' ctermfg=Red' .
    \               ' guibg=' . l:guibg . ' guifg=#ff5454'
endfunction

" Get file format and encoding, if different than unix and utf-8
function! aux#lightline#file_info() abort
    let l:result = ''
    if &fileformat !=? 'unix'
        let l:result .= &fileformat
    endif
    if &fileencoding !=? 'utf-8'
        let l:result .= l:result ==# '' ? '' : ' '
        let l:result .= &fileencoding
    endif
    return l:result
endfunction

function! aux#lightline#warning_count() abort
    let l:count = luaeval("#vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})")
    return l:count == 0 ? '' : printf('%d ⚠', l:count)
endfunction

function! aux#lightline#error_count() abort
    let l:count = luaeval("#vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})")
    return l:count == 0 ? '' : printf('%d ✗', l:count)
endfunction

