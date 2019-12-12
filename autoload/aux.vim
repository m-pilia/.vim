" Convert an uri to a path
function! aux#uri2path(uri) abort
    let l:path = substitute(a:uri, '^file://', '', '')
    let l:path = substitute(l:path, '[?#].*', '', '')
    let l:path = substitute(l:path,
    \                       '%\(\x\x\)',
    \                       '\=printf("%c", str2nr(submatch(1), 16))',
    \                       'g')
    return l:path
endfunction

" Get visual selection
function! aux#visual_selection() abort
    let l:tmp = ''
    try
        let l:tmp = @a
        silent normal! gv"ay
        return @a
    finally
        let @a = l:tmp
    endtry
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
    \  && l:word[strlen(l:word) - 1] !=# ')'
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
        if aux#uri2path(a:msg.uri) !=# expand('%:p')
            return
        endif

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
        if aux#uri2path(a:msg.uri) !=# expand('%:p')
            return
        endif

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
        if aux#uri2path(a:msg.uri) !=# expand('%:p')
            return
        endif

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

" Yank the current file name as a C include directive
function! aux#yank_header() abort
    let @" = '#include "' . expand('%') . '"'
    let @+ = '#include "' . expand('%') . '"'
endfunction

" Run a sequence of keys in normal mode after temporarily setting onemore
function! aux#onemored(keys) abort
    let l:has_onemore = &virtualedit =~# 'onemore'
    silent setlocal virtualedit+=onemore
    try
        silent execute 'normal! ' . a:keys
    finally
        if !l:has_onemore
            silent setlocal virtualedit-=onemore
        endif
    endtry
endfunction

" Return a hiding regex for netrw
function! aux#netrw_list_hide() abort
    let l:Fmt = {k, v -> '^' . substitute(escape(v, ".$~"), "*", ".*", "g") . '/\=$'}
    return join(map(split(&wildignore, ','),  l:Fmt), ',') . ',\(^\|\s\s\)\zs\.\S\+'
endfunction

" Return the absolute path of the file name under cursor
function! aux#netrw_path() abort
    let l:filename = b:netrw_curdir . '/'
    let l:filename .= substitute(getline('.'), '^\v(\s*\|*)*', '', '')
    return fnameescape(l:filename)
endfunction

" Return true if the pop up menu is showing but no item is selected
function! aux#pum_noselect() abort
    return pumvisible() && !empty(v:completed_item)
endfunction

" Recursively convert funcrefs to strings
function! aux#fun2str(obj) abort
    if type(a:obj) == v:t_list
        return map(copy(a:obj), {_, V -> aux#fun2str(V)})
    elseif type(a:obj) == v:t_dict
        let l:result = {}
        for [l:k, l:V] in items(a:obj)
            let l:result[l:k] = aux#fun2str(l:V)
        endfor
        return l:result
    else
        return type(a:obj) == v:t_func ? string(a:obj) : a:obj
    endif
endfunction

" Prettyprint a vim object
function! aux#pprint(obj) abort
    let l:str = shellescape(escape(json_encode(aux#fun2str(a:obj)), '\'))
    return system('echo ' . l:str . '| python -m json.tool')
endfunction

" Detect conflict markers
function! aux#detect_conflict_markers() abort
    syntax region conflictStart start=/^<<<<<<< .*$/ end=/^\ze\(=======$\||||||||\)/
    syntax region conflictMiddle start=/^||||||| .*$/ end=/^\ze=======$/
    syntax region conflictEnd start=/^\(=======$\||||||| |\)/ end=/^>>>>>>> .*$/
endfunction

" Accept the current conflict region
function! aux#accept_conflict() abort
    let l:region = synIDattr(synID(line('.'), col('.'), 0), 'name')
    if l:region !=# 'conflictStart' && l:region !=# 'conflictEnd'
        return
    endif

    let l:begin = searchpos('^<<<<<<< .*$', 'bcnW')[0]
    let l:Middle = {opt -> searchpos('^\(=======$\||||||||\)', opt)[0]}
    let l:end = searchpos('^>>>>>>> .*$', 'cnW')[0]

    if l:region ==# 'conflictStart'
        silent execute l:Middle('cnW') . ',' l:end . 'd'
        silent execute l:begin 'd'
    else
        silent execute l:end 'd'
        silent execute l:begin . ',' l:Middle('bcnW') . 'd'
    endif
endfunction

" Count characters in a string
function! aux#strlen(str) abort
    return len(split(a:str, '\zs'))
endfunction

" Get LaTeX command under cursor
function! s:get_latex(line, col) abort
    let l:i = match(a:line[0 : a:col - 2], '\\[^[:space:]\\]\+$')
    return {'index': l:i, 'string': a:line[l:i : a:col - 2]}
endfunction

" Identify if the cursor is at the end of a LaTeX command
function! aux#is_latex(line, col) abort
    return has_key(g:l2u_symbols_dict, s:get_latex(a:line, a:col).string)
endfunction

" Replace LaTeX command with Unicode equivalent if possible
function! aux#latex2unicode(line, col) abort
    let l:last_col = a:col == col('$')
    if aux#is_latex(a:line, a:col)
        let l:key = s:get_latex(a:line, a:col).string
        execute 'normal! dF\i' . g:l2u_symbols_dict[l:key]
        execute 'normal!' . (l:last_col ? 'll' : 'l')
    endif
endfunction

" Replace LaTeX command with Unicode equivalent in command mode
function! aux#latex2unicode_cmd() abort
    let l:line = getcmdline()
    let l:col = getcmdpos()
    if aux#is_latex(l:line, l:col)
        let l:match = s:get_latex(l:line, l:col)
        let l:end = l:match.index + len(l:match.string)
        let l:prefix = l:match.index > 0 ? l:line[0 : l:match.index - 1] : ''
        let l:char = g:l2u_symbols_dict[l:match.string]
        let l:postfix = len(l:line) > l:end ? l:line[l:end :] : ''
        let l:line = l:prefix . l:char . l:postfix
        call setcmdpos(l:col + len(char) - len(l:match.string))
    else
        call feedkeys("\<Tab>", 'nt')
    endif
    return l:line
endfunction

" Tag generator function based on coc.nvim
function! aux#tagfunc(pattern, flags, info) abort
    let l:name = a:flags ==? 'c' ? a:pattern : expand('<cword>')

    for l:server in keys(filter(copy(g:coc_user_config['languageserver']),
    \                           {_, v -> index(v.filetypes, &filetype) >= 0}))
        try
            let l:symbol_list = CocRequest(l:server, 'workspace/symbol', {'query': l:name})
        catch
            continue
        endtry

        let l:tags = []
        for l:symbol in l:symbol_list
            let l:pos = l:symbol.location.range.start
            call add(l:tags, {
            \   'name': l:name,
            \   'filename': aux#uri2path(l:symbol.location.uri),
            \   'cmd': '/\%' . (l:pos.line + 1) . 'l\%' . (l:pos.character + 1) . 'c/',
            \ })
        endfor

        return l:tags
    endfor

    return v:null
endfunction
