" Grey out regions skipped by C pre-processor
if has('nvim')
    function! aux#skreg#skipped_regions(msg) abort
        if aux#uri2path(a:msg.uri) !=# expand('%:p')
            return
        endif

        let l:buf = nvim_get_current_buf()
        let l:ns = nvim_create_namespace(string(l:buf) . '_skipped_regions')
        call nvim_buf_clear_namespace(l:buf, l:ns, 0, -1)
        for l:range in a:msg.skippedRanges
            for l:line in range(l:range.start.line + 1, l:range.end.line - 2)
                call nvim_buf_add_highlight(l:buf, l:ns, 'CclsSkippedRegion', l:line, 0, -1)
            endfor
        endfor
    endfunction
else
    function! aux#skreg#skipped_regions(msg) abort
        if aux#uri2path(a:msg.uri) !=# expand('%:p')
            return
        endif

        call prop_remove({'type': 'CclsSkippedRegion', 'all': v:true})
        for l:range in a:msg.skippedRanges
            let l:options = {
            \   'type': 'CclsSkippedRegion',
            \   'end_lnum': l:range.end.line - 1,
            \   'end_col': 999,
            \ }
            call prop_add(l:range.start.line + 2, 1, l:options)
        endfor
    endfunction
endif
