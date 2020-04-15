syntax keyword matlabTodo contained TODO FIXME XXX
syntax keyword matlabBool true false

highlight link matlabCellComment Comment
execute 'highlight matlabCellComment '
\                  'cterm=italic,bold '
\                  'ctermfg='synIDattr(synIDtrans(hlID('Comment')), 'fg', 'cterm')
\                  'gui=italic,bold '
\                  'guifg='synIDattr(synIDtrans(hlID('Comment')), 'fg', 'gui')

syntax match matlabSuppression /\v\%\#ok.*/
highlight link matlabSuppression matlabCellComment
highlight link matlabBool Constant
