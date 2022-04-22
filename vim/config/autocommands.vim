if exists('g:vscode')
    finish
endif

" When vimrc is edited, reload it
augroup reloadVimRc " {
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc source %
augroup END " }

" Remove trailing whitespace from selected filetypes
augroup removeWS " {{{
    autocmd!

    "Remove trailing white space {{{
    function! s:RemoveTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
    endfunction

    " }}}
    au FileType c,cpp,h,hpp,qml,pri,pro,vim,vimrc au BufWritePre <buffer> :silent! call s:RemoveTrailingWS()
augroup END " }}}

