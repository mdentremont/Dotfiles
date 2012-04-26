""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GVIM UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide toolbar
set guioptions-=T

set t_Co=256


set columns=120
set lines=30

" When gvimrc is edited, reload it
autocmd! bufwritepost gvimrc source ~/vim_local/gvimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GVIM Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme tango

set gfn=Consolas:h10
