let g:doxygen_enhanced_color=1

runtime! syntax/doxygen.vim

syn region doxygenComment matchgroup=pythonString start=+[uUrR]\=\z('''\|"""\)+ end="\z1" contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend fold containedin=pythonString

" TODO/NOTE
syn match   pythonComment	"#.*$" contains=pythonTodo,pythonNote,@Spell
syn keyword pythonTodo		FIXME TODO XXX contained
syn keyword pythonNote		NOTE NOTES contained
hi  pythonNote ctermfg=Green
hi link pythonTodo		Todo

syn keyword pythonBuiltin	False True None
hi link pythonBuiltin	Function
