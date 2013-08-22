" Enable hard-mode by default
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

