if exists('g:current_compiler')
    finish
endif
let g:current_compiler = 'flake8'

let s:cpo_save = &cpoptions
set cpoptions&vim

" Example message:
" ./test/test_local.py:48:1: W391 blank line at end of file

CompilerSet errorformat=%f:%l:%c:\ %m
CompilerSet makeprg=flake8

let &cpoptions = s:cpo_save
unlet s:cpo_save
