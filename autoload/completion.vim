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

function! s:gh_candidate(str) abort
    let l:tokens = matchlist(trim(a:str), '\v(\d+) (\[.*\]) (.*)')
    let l:id = l:tokens[1]
    let l:title = l:tokens[3]
    let l:labels = l:tokens[2] ==# '[]' ? '' : l:tokens[2]
    return {
    \   'word': '#' . l:id,
    \   'abbr': '#' . l:id . ': ' . l:title . ' ' . l:labels
    \ }
endfunction

" Add candidates and optionally refresh the completion menu.
" Refreshing the completion menu requires completeopt+=noselect.
function! s:gh_callback(refresh, channel, msg) abort
    let b:gh_completions += map(split(a:msg, '\n'), 's:gh_candidate(v:val)')
    call sort(b:gh_completions)
    if a:refresh
        call feedkeys("\<C-x>\<C-o>", 'n')
    endif
endfunction

" Complete GitHub issues and pull requests
"
" Use Hub to fetch a list of issues and pull requests. Since a query with Hub
" usually takes a few seconds, run it asynchronously, and cache the results.
" When called with an optional third argument, initialise the completion cache.
function! completion#github_complete(findstart, base, ...) abort
    if a:findstart
        let line = getline('.')[: col('.')]
        let token = matchstr(getline('.')[: col('.')], '\v#\d*$')
        return strridx(line, token)
    endif

    let l:init = a:0 != 0

    " Asynchronously fetch issues and PRs
    if !exists('b:gh_completions')
        let b:gh_completions = []
        let l:Cb = function('s:gh_callback', [!l:init])
        call job_start('hub issue -f"%I [%L] %t"', {'out_cb': l:Cb})
        call job_start('hub pr list -s all -f"%I [%pS] %t"', {'out_cb': l:Cb})
    endif

    if !l:init
        return filter(copy(b:gh_completions), 'stridx(v:val.word, a:base) == 0')
    endif
endfunction
