" Find LSP root given a list of marker files
function! s:find_root(markers) abort
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
function! s:find_ccls_root() abort
    return s:find_root(['compile_commands.json', '.ccls'])
endfunction

if executable('ccls') && s:find_ccls_root() !=# ''
    let s:ccls_options = {'cache': {'directory': '/tmp/ccls/cache'}}
    augroup vim_lsp
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'ccls',
            \ 'cmd': {server_info -> ['ccls']},
            \ 'root_uri': {server_info -> s:find_ccls_root()},
            \ 'initialization_options': s:ccls_options,
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ })
    augroup END
endif

if executable('clangd')
    augroup vim_lsp
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info -> ['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
    augroup END
endif
