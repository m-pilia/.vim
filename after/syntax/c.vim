syntax match    cNote /\CNOTE\ze:\?/ contained
syn cluster	cCommentGroup	contains=cTodo,cNote,cBadContinuation
hi          cNote               ctermfg=Green
syn cluster cString add=@NoSpell

" ARM NEON types
syntax match cArmNeonIntType /\v<u?int((8x(8|16))|(16x[48])|(32x[24])|(64x[12]))(x[2-4])?_t>/
syntax match cArmNeonFloatType /\v<float((16x[48])|(32x[24]))(x[2-4])?_t>/
syntax match cArmNeonPolyType /\v<poly((8x(8|16))|(16x[48]))(x[2-4])?_t>/
highlight link cArmNeonIntType cType
highlight link cArmNeonFloatType cType
highlight link cArmNeonPolyType cType
