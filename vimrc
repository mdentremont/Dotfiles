set nocompatible
filetype off

" Source the vundle config
source ~/.vim/vundle.vim

" Enable pathogen
call pathogen#infect('~/.vim/bundle')
call pathogen#infect('~/.vim/manual')

source ~/git/search-cs/misc/git/topicmerge.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GVIM Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_running')
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""
    " GVIM UI
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Hide toolbar
    set guioptions-=T

    "set columns=120
    "set lines=30

endif

let g:Powerline_symbols = 'fancy'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700

" Use comma as the leader
let mapleader=","
let g:mapleader=","

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V> "+gP
map <S-Insert> "+gP

cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q> <C-V>

" Disable Ex Mode
nnoremap Q :

" Disable Search Highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

"Tagbar
nnoremap <F4> :TagbarToggle<CR>

" NERDTree
nnoremap <F3> :NERDTreeToggle<CR>

" Move around windows
nmap <C-l> l
nmap <C-h> h
nmap <C-k> k
nmap <C-j> j
"map <C-a> 

" Switch tabs
nmap <C-Tab> gt
imap <C-Tab> <Esc>gt
nmap <C-S-Tab> gT
imap <C-S-Tab> <Esc>gT

" CtrlP buffer list
nnoremap <Space> :CtrlPBuffer<CR>

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" When vimrc is edited, reload it
augroup reloadVimRc " {
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc source %
augroup END " }

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of vimrc
map <leader>e :e! ~/.vim/vimrc<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only scroll at the border
set so=0

" Bash-like tab completion on file/command names
set wildmenu

" Ignore case when searching
set ignorecase

" If search contains uppercase, override case-insensitivity
set smartcase

" Highlight next search result
set hlsearch

" Highlight all results
set incsearch

" Commandbar height
set cmdheight=2

" Always show position
set ruler

" Show line breaks
set showbreak=→

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

" Have to excape magic chars (except "(,)" and "|"
set magic

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Show relative line numbers
set relativenumber

" Show matching braces
set showmatch

" How many tenths of a second to blink
set mat=2

" No error bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set t_Co=256

set background=dark
colorscheme molokai


" Enable powerline
set guifont=Liberation\ Mono\ for\ Powerline\ 10

" No line numbers
set nonu

set encoding=utf8

set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup
set backupdir=~/.vim/backup

set noswapfile

"Persistent undo
try
    if MySys() == "windows"
      set undodir=%TMP%
    else
      set undodir=~/.vim/undodir
    endif

    set undofile
catch
endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set linebreak

" list disables linebreak
set nolist
"set tw=500
set textwidth=0
set wrapmargin=0

set ai
set si
set wrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search for current selection on * or #
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Press gv to vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern . "^M"

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
" Buf number, help file, modified, read only, preview window flag
set statusline+=[%n%H%M%R%W]%*\  
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <m-j> mz:m+<cr>`z
nmap <m-k> mz:m-2<cr>`z
vmap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

"Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
  retab
endfunc

augroup deleteWS " {
    autocmd!
    autocmd BufWrite *.qml :call DeleteTrailingWS()
    autocmd BufWrite *.cpp :call DeleteTrailingWS()
    autocmd BufWrite *.hpp :call DeleteTrailingWS()
    autocmd BufWrite *.pro :call DeleteTrailingWS()
augroup END " }

set guitablabel=%t

