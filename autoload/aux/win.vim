" Return a PowerShell command in form of string, callable with system().
function! s:ps(cmd) abort
    return 'powershell.exe -noprofile -noninteractive -command "' . a:cmd . '"'
endfunction

" Escape string to be usable as input to PowerShell from a bash-like shell
"
" First, double all single quotes (escape for Powershell). Then, replace
" all single quotes with '"'"' (escape for bash) and enclose everything
" within single quotes.
function! s:psescape(str) abort
    return "'" . substitute(escape(a:str, '\'), "'", repeat("'\"'\"'", 2), 'g') . "'"
endfunction

" Read the clipboard when has('clipboard') is false
"
" The {cmd} argument is a string containing a command involving a
" register, where the register is denoted by the placeholder character
" \r (the carriage return character, unescaped). Such register will
" contain the content of the clipboard.
"
" Example:
"   " Paste clipboard content
"   :call aux#win#read_clipboard("normal! \"\rp")
function! aux#win#read_clipboard(cmd) abort
    if !executable('powershell.exe')
        return
    endif
    let l:clip = system(s:ps('Get-Clipboard') . " | sed 's,\r*$,,'")
    let l:bak = @a
    try
        let @a = l:clip
        silent execute substitute(a:cmd, "\r", 'a', '')
    finally
        let @a = l:bak
    endtry
endfunction

" Send yanked content to the clipboard when has('clipboard') is false
" To be called by TextYankPost event. Write only when yanking to the
" clipboard register (+).
function! aux#win#write_clipboard() abort
    if !executable('powershell.exe') || v:event.regname !=? '+'
        return
    endif
    let l:clip = s:psescape(join(v:event.regcontents, "\<cr>"))
    silent call system('echo -n ' . l:clip . ' | ' . s:ps('\$Input | Set-Clipboard'))
endfunction
