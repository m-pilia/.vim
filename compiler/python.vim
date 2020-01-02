if exists('g:current_compiler')
    finish
endif
let g:current_compiler = 'python'

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet errorformat=
    \%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,
    \%*\\sFile\ \"%f\"\\,\ line\ %l,
CompilerSet makeprg=python\ %

let &cpoptions = s:cpo_save
unlet s:cpo_save
