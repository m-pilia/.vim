setlocal omnifunc=completion#github_complete

" Init the autocompletion cache
call completion#github_complete(v:false, 0, 'init')
