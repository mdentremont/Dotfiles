set rtp+=~/.vim/bundle/vundle/
call vundle#rc("~/.vim/bundle")

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"" To disable a plugin, add it's bundle name to the following list
"let g:pathogen_disabled = []
"
"if !has('gui_running')
"    call add(g:pathogen_disabled, 'vim-powerline')
"endif

" My Bundles here:
"
" original repos on github
Bundle 'corntrace/bufexplorer.git'
Bundle 'dantler/vim-alternate.git'
Bundle 'edsono/vim-matchit.git'
Bundle 'ervandew/supertab.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'majutsushi/tagbar.git'
Bundle 'SirVer/ultisnips.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'tomasr/molokai.git'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'Valloric/YouCompleteMe.git'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

" required!
filetype plugin indent on
