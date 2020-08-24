set nocompatible

fun! MySys()
    if has("mac")
        return "mac"
    elseif has("unix")
        return "linux"
    elseif has("win32")
        return "windows"
    endif

    return "unknown"
endfun

" Source the vundle config
source ~/.vim/vundle.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GVIM Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""
    " GVIM UI
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Hide toolbar
    set guioptions-=T

    " Disable window key shortcuts
    set winaltkeys=no

    if MySys() == "mac"
        " Treat Alt/Option as meta in MacVim
        set macmeta
    endif

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NeoVim Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
"    set timeout
"    set timeoutlen=0
"    set ttimeout
    set ttimeoutlen=-1
else
    set ttimeoutlen=50
endif

if has("nvim")
    nmap <BS> <C-h>
    tnoremap <Esc> <C-\><C-n>
    tnoremap <S-Esc> <Esc>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use bash for shells to avoid delays in zsh starting up
if has('unix')
    set shell=/bin/bash
endif

set history=1000

" Hide a buffer instead of closing (don't lose unsaved changes!)
set hidden

" Enable filetype plugin
filetype plugin on

" Allow indentation to be filetype dependent
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" chdir for each open file
set autochdir

" Add BBNDK tags to the tags list
"set tags=./tags/;/,$GIT_HOME/tags;/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ZSH-like tab completion in menu
set wildmenu

set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a

" shell style completion, double tab cycles
set wildmode=list:longest,full

" Only scroll at the border
set so=0

" Ignore case when searching
set ignorecase

" If search contains uppercase, override case-insensitivity
set smartcase

" Highlight next search result
set hlsearch

" Commandbar height
set cmdheight=2

" Show line breaks
set showbreak=→

" Don't show the mode as airline already does this
set noshowmode

" Enable mouse
set mouse=nvr

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

" Have to excape magic chars (except "(,)" and "|"
set magic

" Set backspace config
set whichwrap+=<,>,h,l

" Highlight cursor line and column
set cursorline
set cursorcolumn

" Show relative line numbers
if v:version > 703
    set relativenumber
    set number
endif

" Show matching braces
set showmatch

" How many tenths of a second to blink
set mat=1

" Folding settings {{{
set nofoldenable
"" }}}

" No error bells
set noerrorbells
set novisualbell
set t_vb=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set t_Co=256

"if !has('gui_running')
"    let g:rehash256 = 1
"endif

set background=dark
colorscheme wombat256mod

set encoding=utf8
set termencoding=utf-8

set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup
set backupdir=~/.vim/backup

set noswapfile

"Persistent undo
if MySys() == "windows"
  set undodir=%TMP%
else
  set undodir=~/.vim/undodir
endif

set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab
set shiftwidth=4
set tabstop=4

autocmd FileType javascript set shiftwidth=2 tabstop=2

set nolinebreak

" list disables linebreak
set nolist
"set tw=500
set textwidth=0
set wrapmargin=0

set smartindent
set wrap

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""

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

set guitablabel=%t

" Source viminit files {{{
for src in split(glob("~/.vim/config/*.vim"), "\n")
    execute "source " . src
endfor
for src in split(glob("~/.vim/config/**/*.vim"), "\n")
    execute "source " . src
endfor
" }}}

