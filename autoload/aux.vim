" Find LSP root given a list of marker files
function! aux#find_root(markers) abort
    let l:path = lsp#utils#get_buffer_path()
    for l:m in a:markers
        let l:uri = lsp#utils#find_nearest_parent_file_directory(l:path, l:m)
        if l:uri !=# ''
            return lsp#utils#path_to_uri(l:uri)
        endif
    endfor
    return ''
endfunction

" Find the root of a ccls project
function! aux#find_ccls_root() abort
    return aux#find_root(['compile_commands.json', '.ccls'])
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

" Send current line if the shell is active, otherwise start it
function! aux#screenshell_call() abort
    if g:ScreenShellActive
        call g:ScreenShellSend(trim(getline('.')))
    else
        if has_key(g:screenshell_commands, &filetype)
            execute 'ScreenShell ' . g:screenshell_commands[&filetype]
        else
            ScreenShell
        endif
    endif
endfunction

" Send visual selection buffer to the shell
function! aux#screenshell_send() abort
    if g:ScreenShellActive
        call g:ScreenShellSend(@*)
    endif
    normal! gv
endfunction

" Quit the shell
function! aux#screenshell_quit() abort
    if g:ScreenShellActive
        ScreenQuit
    endif
endfunction

" Toggle between forward slash and backslash in visual selection
function! aux#convert_path() abort
    if match(@*, '/') >= 0
        execute 's:\%V/:\\:g'
    elseif match(@*, '\') >= 0
        execute ':s:\%V\\:/:g'
    endif
    normal! gv
endfunction

" Auto switch paste mode when pasting (requires +clipboard)
function! aux#auto_paste() abort
    let l:nopaste = 0
    if (!&paste)
        set paste
        let l:nopaste = 1
    endif
    normal! "+p
    if nopaste
        set nopaste
    endif
endfunction

" Commute between upper, lower, and title case in visual selection
function! aux#twiddle_case() abort
    let l:selection = @*
    if l:selection ==# toupper(l:selection)
        normal! gvu
    elseif l:selection ==# tolower(l:selection)
        execute ':s:\%V\v(<\w+>):\u\1:g'
    else
        normal! gvU
    endif
    normal! gv
endfunction

" Set different text width according to the syntax region
function! aux#set_text_width(re, tw, cw) abort
    let l:winview = winsaveview()
    let l:region = synIDattr(synID(line('.'), col('.'), 0), 'name')
    if match(l:region, a:re) >= 0
        execute 'setlocal textwidth=' . a:tw
    else
        execute 'setlocal textwidth=' . a:cw
    endif
    call winrestview(l:winview)
endfunction
