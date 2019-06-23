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
function! aux#lightline#colours(colour_add, colour_change, colour_delete) abort
    let l:mode = get(s:map, tolower(mode()[0]), 'normal')
    let l:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
    let l:palette = l:palette[l:mode]['left'][1]
    let [l:termbg, l:guibg] = [l:palette[3], l:palette[1]]
    exec 'highlight GitStatusLineAdd '
    \               'ctermbg=' . l:termbg . ' ctermfg=' . a:colour_add .
    \               ' guibg=' . l:guibg . ' guifg=' . a:colour_add
    exec 'highlight GitStatusLineChange '
    \               'ctermbg=' . l:termbg . ' ctermfg=' . a:colour_change .
    \               ' guibg=' . l:guibg . ' guifg=' . a:colour_change
    exec 'highlight GitStatusLineDelete '
    \               'ctermbg=' . l:termbg . ' ctermfg=' . a:colour_delete .
    \               ' guibg=' . l:guibg . ' guifg=' . a:colour_delete
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

" Statusline for CtrlP
function! aux#lightline#CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) abort
    return lightline#statusline(0)
endfunction

" Statusline for CtrlP
function! aux#lightline#CtrlPStatusFunc_2(str) abort
    return lightline#statusline(0)
endfunction
