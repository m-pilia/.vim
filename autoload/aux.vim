" Get visual selection
function! aux#visual_selection() abort
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

" Map a list of keys to <nop>
function! aux#disable_keys(keys) abort
    for l:key in a:keys
        for l:map in ['nnoremap', 'inoremap', 'vnoremap']
            for l:modifier in ['', 'C-', 'S-']
                silent exec l:map . ' <' . l:modifier . l:key . '> <nop>'
            endfor
        endfor
    endfor
endfunction

" Grey out regions skipped by C pre-processor
if has('textprop')
    function! aux#skipped_regions(msg) abort
        call prop_remove({'type': 'ccls_skipped_region', 'all': v:true})
        for l:range in a:msg.skippedRanges
            let l:options = {
            \   'type': 'ccls_skipped_region',
            \   'end_lnum': l:range.end.line - 1,
            \   'end_col': 999,
            \ }
            call prop_add(l:range.start.line + 2, 1, l:options)
        endfor
    endfunction
elseif has('nvim')
    function! aux#skipped_regions(msg) abort
        let l:buf = nvim_get_current_buf()
        let l:ns = nvim_create_namespace(string(l:buf))
        call nvim_buf_clear_namespace(l:buf, l:ns, 0, -1)
        for l:range in a:msg.skippedRanges
            for l:line in range(l:range.start.line + 1, l:range.end.line - 2)
                call nvim_buf_add_highlight(l:buf, l:ns, 'CclsSkippedRegion', l:line, 0, -1)
            endfor
        endfor
    endfunction
else
    function! aux#skipped_regions(msg) abort
        if exists('w:ccls_skipped_regions')
            for l:match in w:ccls_skipped_regions
                silent! call matchdelete(l:match)
            endfor
        endif
        let w:ccls_skipped_regions = []
        for l:range in a:msg.skippedRanges
            for l:line in range(l:range.start.line + 2, l:range.end.line - 1)
                let l:match = matchaddpos('CclsSkippedRegion', [l:line], -5)
                silent! call add(w:ccls_skipped_regions, l:match)
            endfor
        endfor
    endfunction
endif
