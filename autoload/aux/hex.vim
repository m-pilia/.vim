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

" http://www.charles-keepax.co.uk/blog/IntelHEXChecksumsInVim.html
function! aux#hex#ihex_checksum() abort range
    for l:lnum in range(a:firstline, a:lastline)
        let l:data = getline(l:lnum)
        let l:len = strlen(l:data)

        if empty(matchstr(l:data, "^:\\(\\x\\x\\)\\{5,}$"))
            break
        endif

        let l:checksum = 0
        for l:bytepos in range(1, l:len - 4, 2)
            let l:checksum += str2nr(strpart(l:data, l:bytepos, 2), 16)
        endfor

        let l:checksum = (256 - (l:checksum % 256)) % 256

        call setline(l:lnum, strpart(l:data, 0, l:len - 2) . printf('%02X', l:checksum))
    endfor
endfunction
