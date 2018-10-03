syn match racketComment /;.*$/ contains=racketTodo,racketNote,@Spell
syn region racketMultilineComment start=/#|/ end=/|#/ contains=racketMultilineComment,racketTodo,racketNote,@Spell
syntax match racketNote /\CNOTE\ze:\?/ contained
hi     racketNote               ctermfg=Green 
