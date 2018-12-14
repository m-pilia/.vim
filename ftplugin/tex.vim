" Match dollar signs
let b:AutoPairs = g:AutoPairs
let b:AutoPairs['$'] = '$'

" Shell command for TeX word count from stdin
function! TeXWCcommand()
    return 'perl -X `command -v texcount` - | ' .
                \       "grep 'Words in text' | " .
                \       "egrep -o '[0-9]+' | " .
                \       "tr -d '\\r\\n'"
endfunction

" TeX word count on whole file
function! TeXWC()
    echo system('cat ' . expand('%') . ' | ' . TeXWCcommand()) . ' words'
endfunction

" Detailed output
function! TeXWCdetailed()
    echo system('perl -X `command -v texcount` ' . expand('%'))
endfunction

" TeX word count on range
function! TeXWCRange() range
    let text = shellescape(join(getline(a:firstline, a:lastline), '\n'))
    let text = substitute(text, '\\', '\\\\', 'g')
    let words =  system('echo ' . text . ' | ' . TeXWCcommand())
    echo words . ' words'
    call getchar()
endfunction

command! TeXWC call TeXWC()
command! TeXWCdetailed call TeXWCdetailed()
command! -range TeXWCrange <line1>,<line2>call TeXWCRange()
