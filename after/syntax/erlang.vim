syn match erlangComment           '%.*$' contains=erlangCommentAnnotation,erlangTodo,erlangNote
syntax match erlangNote /\CNOTE\ze:\?/ contained
hi     erlangNote ctermfg=Green 
