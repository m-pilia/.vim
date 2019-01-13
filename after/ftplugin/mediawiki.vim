" Quick format (requires vim-surround)
let b:surround_{char2nr('l')} = "[[\r]]"
let b:surround_{char2nr('b')} = "'''\r'''"
let b:surround_{char2nr('i')} = "''\r''"
let b:surround_{char2nr('h')} = "== \r =="
let b:surround_{char2nr('r')} = "<ref> \r </ref>"
