scriptencoding utf-8

" Get git branch and status summary for the current file
function! aux#lightline#git_status() abort
    let l:result  = '%{get(g:, "coc_git_status", "") == "" ? "no repo" : g:coc_git_status}'
    let l:open    = '%{get(b:, "coc_git_status", "") == "" ? "" : "  ("}'
    let l:close   = '%{get(b:, "coc_git_status", "") == "" ? "" : ")"}'
    let l:added   = '%#GitStatusLineAdd#%{aux#lightline#git_added()}'
    let l:changed = '%#GitStatusLineChange#%{aux#lightline#git_changed()}'
    let l:deleted = '%#GitStatusLineDelete#%{aux#lightline#git_deleted()}'
    let l:reset_colour = '%#LightlineLeft_active_1#'
    return l:result . l:open . l:added . l:changed . l:deleted . l:reset_colour . l:close
endfunction

function! aux#lightline#git_added() abort
     return matchstr(get(b:, 'coc_git_status', ''), '\v(\+[0-9]+)')
endfunction

function! aux#lightline#git_changed() abort
     return matchstr(get(b:, 'coc_git_status', ''), '\v(\~[0-9]+)')
endfunction

function! aux#lightline#git_deleted() abort
     return matchstr(get(b:, 'coc_git_status', ''), '\v(\-[0-9]+)')
endfunction

let s:map = {
\   'n': 'normal',
\   'i': 'insert',
\   'v': 'visual',
\   'r': 'replace',
\ }

" Update the highlight groups for the git status
" Use in autocmd if the lightline theme has different colours for different modes
function! aux#lightline#colours() abort
    let l:mode = get(s:map, tolower(mode()[0]), 'normal')
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

" Diagnostic status
function! aux#lightline#count() abort
    let l:error = 0
    let l:other = 0
    let l:info = get(b:, 'coc_diagnostic_info', {})
    if !empty(l:info)
        let l:error = l:info.error
        let l:other = l:info.warning + l:info.information + l:info.hint
    endif
    let l:total = l:info.error + l:other
    return {'total': l:total, 'error': l:error, 'other': l:other}
endfunction

function! aux#lightline#warning_count() abort
    let l:count = aux#lightline#count()
    return l:count.total == 0 ? '' : printf('%d ⚠', l:count.other)
endfunction

function! aux#lightline#error_count() abort
    let l:count = aux#lightline#count()
    return l:count.total == 0 ? '' : printf('%d ✗', l:count.error)
endfunction
