let g:load_doxygen_syntax = 1

setlocal comments^=:///

setlocal syntax=cpp.doxygen

setlocal cindent
setlocal cinoptions=j1,(0

augroup cpp_text_objects
    autocmd!

    autocmd VimEnter * call textobj#user#plugin('cpp', {
    \   'numbers': {
    \     'pattern': '[+-]\?\([0-9]*\.\)\?[0-9]\+\([eE][+-]\?[0-9]\+\)\?'
    \                . '\([fF]16\|[fF]32\|[fF]64\|[fF]128\|bf16\|BF16\|[FfUuLlzZ]*\)\?',
    \     'select': ['an', 'in'],
    \   },
    \ })
augroup END
