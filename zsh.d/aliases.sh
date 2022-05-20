# ZSH aliases

if [[ `uname` != 'Darwin' ]]
then
    alias ls='ls --color'
fi
alias o='open "$@"'

if hash nvim 2>/dev/null; then
    alias vi=nvim
    alias vim=nvim
else
    alias vi=vim
fi

if hash docker 2>/dev/null; then
    alias docker-volume-cleanup='docker volume rm $(docker volume ls -qf dangling=true)'
    alias d='docker'
    alias dc='docker-compose'
    alias dm='docker-machine'
fi

if hash fuck 2>/dev/null; then
  eval $(thefuck --alias)
fi

# Fix ag colours
alias ag='ag --color-line="0;33" --color-path="0;32"'

# Alias gv to gvim if it exists
if hash gvim 2>/dev/null; then
    function gv { ( gvim -f "$@" & ) &>/dev/null ; }
    compdef gv=gvim
fi

qf() {
    cmd=$(fc -rnlIL -m '[ar]g*' -2 2>/dev/null | head -n1 | sed 's/^rg/rg --vimgrep/')
    [[ -z $cmd ]] && return 1
    vim -q =(eval ${cmd}) -c 'copen'
}

# Only set git aliases if git exists
if hash git 2>/dev/null; then
    # Git aliases
    # Use hub if it exists
    if hash hub 2>/dev/null; then
        alias g="hub"
        alias git="hub"
        compdef hub=git
    else
        alias g="git"
    fi

    alias gb="git b"

    alias gd="git diff"

    alias gdc="git diff --cached"

    if hash "/mnt/c/Program\ Files/Git/cmd/git-gui.exe" 2>/dev/null; then
        alias gg="/mnt/c/Program\ Files/Git/cmd/git-gui.exe &"
    fi

    alias gl="git l"

    alias glp="git lp"

    alias gs="git status -sb"
fi

if hash spin 2>/dev/null; then
    alias ss='spin shell'
    alias sc='spin code'
    alias scs='spin code -l shopify--shopify'
fi

alias br='bin/rails'

