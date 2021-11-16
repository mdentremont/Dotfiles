call plug#begin('~/.vim/bundle')

"if has("unix")
"    echo "Installing patched fonts"
"    git clone https://github.com/Lokaltog/powerline-fonts ~/.fonts
"    fc-cache -vf ~/.fonts
"endif

"
" original repos on github
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
"Plug 'honza/vim-snippets'
"Plug 'jmcantrell/vim-virtualenv'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-distinguished'
Plug 'Lokaltog/vim-easymotion'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'mustache/vim-mustache-handlebars'
"Plug 'Raimondi/delimitMate'
"Plug 'rygwdn/tagswitch'
"Plug 'rking/ag.vim'
"Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
" syntax highlighting support for many languages
Plug 'sheerun/vim-polyglot'
Plug 'sheerun/vim-wombat-scheme'
Plug 'sjl/gundo.vim'
"Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"Plug 'vimoutliner/vimoutliner'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/matchit.zip'

if !has("nvim")
    Plug 'tpope/vim-sensible'
endif

" JS
"Plug 'pangloss/vim-javascript'
"Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
"Plug 'dsawardekar/portkey', {'for': 'javascript'}
"Plug 'matthewsimo/angular-vim-snippets', {'for': ['javascript', 'html']}
"Plug 'burnettk/vim-angular', {'for': ['javascript', 'html']}
"Plug 'mattn/emmet-vim', {'for': 'html'}

call plug#end()
