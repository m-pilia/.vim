" Find LSP root given a marker file
function! aux#find_root(mark) abort
    let l:path = lsp#utils#get_buffer_path()
    let l:parent = lsp#utils#find_nearest_parent_file_directory(l:path, a:mark)
    return lsp#utils#path_to_uri(l:parent)
endfunction

" Toggle extra ALE linters
function! aux#toggle_extra_linters() abort
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

" Check whether the current window is a location list
function! aux#is_loclist() abort
    return getwininfo(win_getid())[0]['loclist']
endfunction
