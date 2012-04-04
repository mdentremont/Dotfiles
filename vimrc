""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/vim_local/vimrc

let mapleader=","
let g:mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of vimrc
map <leader>e :e! ~/vim_local/vimrc<cr>

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

" Have to excape magic chars (except "(,)" and "|"
set magic

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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

set background=dark

" No line numbers
set nonu

set encoding=utf8

set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set noswapfile

"Persistent undo
try
    if MySys() == "windows"
      set undodir=%TMP%
    else
      set undodir=~/.vim_runtime/undodir
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

set lbr
set tw=500

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
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

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
autocmd BufWrite *.qml :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.hpp :call DeleteTrailingWS()
autocmd BufWrite *.xml :call DeleteTrailingWS()
autocmd BufWrite *.pro :call DeleteTrailingWS()

set guitablabel=%t

