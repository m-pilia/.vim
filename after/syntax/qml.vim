" delete the following line if you don't want to have enhanced colors
let g:doxygen_enhanced_color=1
" following line enables automatic comment continuation
set formatoptions+=r
runtime! syntax/doxygen.vim
syn region doxygenComment matchgroup=qmlComment start=+[uU]\=\(/\*\*\|/\*!\)\@<=+ end=+\*/\@<=+ contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend fold containedin=qmlComment
syn region doxygenComment matchgroup=qmlComment start=+[uU]\=\(///\|//!\)\@<=+ end=+\n+ contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend fold containedin=qmlComment
