set formatoptions+=t
set formatoptions-=l

" Continue indentation on bullet lists (treat them as comment blocks)
setlocal formatoptions+=r
setlocal comments+=fb:*,fb:-,fb:+

" Always start with the cursos at the beginning of the file
normal! gg
