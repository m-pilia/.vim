syntax match    cNote /\CNOTE\ze:\?/ contained
syn cluster	cCommentGroup	contains=cTodo,cNote,cBadContinuation
hi          cNote               ctermfg=Green
syn cluster cString add=@NoSpell
