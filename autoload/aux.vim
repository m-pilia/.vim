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

" Yank the current file name as a C include directive
function! aux#yank_header() abort
    let @" = '#include "' . expand('%') . '"'
    let @+ = '#include "' . expand('%') . '"'
endfunction

" Yank the current file name as a Python import statement
function! aux#yank_python_import() abort
    let l:import = 'import ' . substitute(expand('%:r'), '/', '.', 'g')
    let @" = l:import
    let @+ = l:import
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

" Load a Python stack trace from the clipboard to the quickfix window
function! aux#python_stack_trace_to_quickfix() abort
    compiler python
    let l:saved_makeprg = &l:makeprg
    try
        " Feed makeprg from clipboard, avoiding direct calls to a platform-specific clipboard tool
        let l:temporary_file = tempname()
        let l:escaped_path = substitute(l:temporary_file, ' ', '\\ ', 'g')
        call writefile(split(getreg('+'), "\n"), l:temporary_file)
        execute 'setlocal makeprg=cat\ \"' . l:escaped_path . '\"'
        silent make
        copen
    finally
        let &l:makeprg = l:saved_makeprg
        call delete(l:temporary_file)
    endtry
endfunction

" Open a new scratch buffer
function! aux#scratch() abort
    new
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    nnoremap <silent> <buffer> q :q<cr>
endfunction

" Show all 256 xterm colour in a scratch buffer
function! aux#colour_demo_xterm256() abort
    call aux#scratch()
    setlocal tabstop=13
    setlocal notermguicolors

    let l:line = 1
    for l:num in range(0, 255)
        exec 'hi col_' . l:num . ' ctermbg=' . l:num . ' ctermfg=white'
        exec 'syn match col_' . l:num . ' "ctermbg=' . l:num . '\t" containedIn=ALL'
        call setline(l:line, getline(l:line) . 'ctermbg=' . l:num . "\t")

        if (l:num % 4 == 3) || (l:num == 255)
            call setline(l:line, getline(l:line) . ' |')
            let l:line += 1
        else
            call setline(l:line, getline(l:line) . ' ')
        endif
    endfor
endfunction

" Search for a file in ancestor directories
function! aux#edit_file(filename) abort
    let l:path = findfile(a:filename, '.;')
    if l:path !=# ''
        execute 'e ' . l:path
    endif
endfunction

" Open build file with given name and jump to current file name
function! aux#build_file(filename) abort
    let l:file_name = expand('%:t')
    call aux#edit_file(a:filename)
    call searchpos(l:file_name)
endfunction
