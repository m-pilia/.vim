let g:doxygen_enhanced_color=1

runtime! syntax/doxygen.vim

syntax region doxygenComment matchgroup=pythonString start=+[uUrR]\=\z('''\|"""\)+ end="\z1" contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend fold containedin=pythonString

" TODO/NOTE
syntax match   pythonComment	"#.*$" contains=pythonTodo,pythonNote,@Spell
syntax keyword pythonTodo		FIXME TODO XXX contained
syntax keyword pythonNote		NOTE NOTES contained
highlight  pythonNote ctermfg=Green
highlight link pythonTodo		Todo

syntax keyword pythonBuiltin	False True None
highlight link pythonBuiltin	Function

highlight link @constant.python Normal
highlight link @constructor.python Type
highlight link @function.builtin.python Function
highlight link @type.builtin.python Type
