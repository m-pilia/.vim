" delete the following line if you don't want to have enhanced colors
let g:doxygen_enhanced_color=1
" following line enables automatic comment continuation
set formatoptions+=cro
runtime! syntax/doxygen.vim

syn match cudaBrackets "<<<\|>>>"
hi def link cudaBrackets Repeat

syn keyword cudaStorageClass __forceinline__ __restrict__

