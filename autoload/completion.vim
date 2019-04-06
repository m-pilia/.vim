" From https://github.com/tracyone/vinux
function! s:get_input() abort
    let l:col = col('.')
    let l:line = getline('.')
    if l:col - 1 < len(l:line)
        return matchstr(l:line, '^.*\%' . l:col . 'c')
    endif
    return l:line
endfunction

" From https://github.com/tracyone/vinux
function! completion#vim_complete(findstart, base) abort
    let l:line_prefix = s:get_input()
    if a:findstart
        let l:ret = necovim#get_complete_position(l:line_prefix)
        if l:ret < 0
            return col('.')
        endif
        return l:ret
    else
        return necovim#gather_candidates(l:line_prefix . a:base, a:base)
    endif
endfunction
