" Get visual selection
function! aux#visual_selection()
    let l:tmp = ''
    try
        let l:tmp = @a
        normal! gv"ay
        return @a
    finally
        let @a = l:tmp
    endtry
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
        call g:ScreenShellSend(aux#visual_selection())
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
    let l:visual_selection = aux#visual_selection()
    if match(l:visual_selection, '/') >= 0
        execute 's:\%V/:\\:g'
    elseif match(l:visual_selection, '\') >= 0
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
    let l:selection = aux#visual_selection()
    echom l:selection
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

" Delete all matches from a certain group
function! aux#matchdelete(group) abort
    for l:match in getmatches()
        if l:match.group =~ a:group
            call matchdelete(l:match.id)
        endif
    endfor
endfunction

" Get search query for the word under cursor
function! aux#vimhelp() abort
    let l:word = expand('<cword>')
    if match(strpart(getline('.'), col('.')), '^\i*(') >= 0
        let l:word .= '()'
    endif
    return l:word
endfunction
