if has('nvim')
    function! s:clean_semantic_highlight() abort
        let l:buf = nvim_get_current_buf()
        let l:ns = nvim_create_namespace(string(l:buf) . '_semantic_hl')
        call nvim_buf_clear_namespace(l:buf, l:ns, 0, -1)
        return [l:buf, l:ns]
    endfunction

    function! s:highlight_range(buf, ns, range, prop) abort
        let l:line = a:range.start.line
        let l:start = a:range.start.character
        let l:end = a:range.end.character
        call nvim_buf_add_highlight(a:buf, a:ns, a:prop, l:line, l:start, l:end)
    endfunction
else
    function! s:clean_semantic_highlight() abort
        for l:prop in ['CclsType', 'CclsMacro']
            call prop_remove({'type': l:prop, 'all': v:true})
        endfor
        return [0, 0]
    endfunction

    function! s:highlight_range(buf, ns, range, prop) abort
        let l:options = {
        \   'type': a:prop,
        \   'end_lnum': a:range.end.line + 1,
        \   'end_col': a:range.end.character + 1,
        \ }
        call prop_add(a:range.start.line + 1, a:range.start.character + 1, l:options)
    endfunction
endif

" Semantic highlighting
"
" SymbolKind from https://github.com/MaskRay/ccls/blob/master/src/lsp.hh
"     5: class
"    10: enum
"    11: interface
"    22: enum member
"    23: struct
"    26: type parameter
"   252: type alias
"   255: macro
function! aux#semhl#semantic_highlight(msg) abort
    if aux#uri2path(a:msg.uri) !=# expand('%:p')
        return
    endif

    let [l:buf, l:ns] = s:clean_semantic_highlight()

    for l:symbol in a:msg.symbols
        if index([5, 10, 11, 23, 26, 252], l:symbol.kind) >= 0
            let l:prop = 'CclsType'
        elseif l:symbol.kind == 255
            let l:prop = 'CclsMacro'
        else
            continue
        endif

        for l:range in l:symbol.lsRanges
            call s:highlight_range(l:buf, l:ns, l:range, l:prop)
        endfor
    endfor
    redraw
endfunction

