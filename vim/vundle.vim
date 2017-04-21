filetype off

" Clone Vundle if it doesn't exist yet. From:
"     http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    if has("unix")
        echo "Installing patched fonts"
        git clone https://github.com/Lokaltog/powerline-fonts ~/.fonts
        fc-cache -vf ~/.fonts
    endif
    let iCanHazVundle=0
endif

" Enable manual installation of plugins in .vim/manual
set rtp+=~/.vim/manual/*

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'airblade/vim-gitgutter.git'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'corntrace/bufexplorer.git'
Bundle 'godlygeek/tabular.git'
Bundle 'honza/vim-snippets.git'
Bundle 'JarrodCTaylor/vim-ember-cli-test-runner'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'jnurmine/Zenburn.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'Lokaltog/vim-distinguished.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'majutsushi/tagbar.git'
Bundle 'matze/vim-move.git'
Bundle 'mustache/vim-mustache-handlebars.git'
Bundle 'quanganhdo/grb256.git'
Bundle 'Raimondi/delimitMate.git'
Bundle 'rodjek/vim-puppet.git'
Bundle 'rygwdn/tagswitch.git'
Bundle 'rygwdn/qmake-syntax-vim.git'
Bundle 'rking/ag.vim'
Bundle 'SirVer/ultisnips.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'terryma/vim-multiple-cursors.git'
Bundle 'tfnico/vim-gradle.git'
Bundle 'tomasr/molokai.git'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-eunuch.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-sensible.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'Valloric/YouCompleteMe.git'
Bundle 'vimoutliner/vimoutliner.git'
Bundle 'vim-airline/vim-airline.git'
Bundle 'vim-airline/vim-airline-themes.git'
Bundle 'vim-scripts/matchit.zip.git'

" JS
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
Bundle 'dsawardekar/portkey', {'for': 'javascript'}
Bundle 'dsawardekar/ember.vim', {'for': 'javascript'}
Bundle 'matthewsimo/angular-vim-snippets', {'for': ['javascript', 'html']}
Bundle 'burnettk/vim-angular', {'for': ['javascript', 'html']}
Bundle 'mattn/emmet-vim', {'for': 'html'}
Bundle 'othree/html5.vim', {'for': 'html'}

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

" If plugins don't exist, install them
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" required!
filetype plugin indent on
