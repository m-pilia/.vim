" Toggle hex mode
" https://vim.fandom.com/wiki/Improved_hex_editing
function! aux#hex#toggle_hex() abort
    let l:modified = &modified
    let l:oldreadonly = &readonly
    let &readonly=0
    let l:oldmodifiable = &modifiable
    let &modifiable = 1

    if !exists('b:hex_mode') || !b:hex_mode
        let b:hex_oldfiletype = &filetype
        let b:hex_oldbinary = &binary
        setlocal binary
        silent :e
        let &filetype = 'xxd'
        let b:hex_mode = 1
        %!xxd
    else
        let &filetype = b:hex_oldfiletype
        if !b:hex_oldbinary
            setlocal nobinary
        endif
        let b:hex_mode = 0
        %!xxd -r
    endif

    let &modified = l:modified
    let &readonly = l:oldreadonly
    let &modifiable = l:oldmodifiable
endfunction

