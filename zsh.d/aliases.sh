# ZSH aliases

if hash eza 2>/dev/null; then
    alias ls=eza
elif [[ `uname` != 'Darwin' ]]
then
    alias ls='ls --color'
fi
alias o='open "$@"'

if hash nvim 2>/dev/null; then
    alias v=nvim
    alias vi=nvim
    alias vim=nvim
else
    alias v=vim
    alias vi=vim
fi

if hash fuck 2>/dev/null; then
  eval $(thefuck --alias)
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

if functions dev >/dev/null; then
    alias dcd='dev cd'
fi

if hash spin 2>/dev/null; then
    alias s='s'
    alias sl='spin list'
    alias sc='spin code'
    alias scl='spin code -l'
    alias scs='spin code -l shop--world//areas/core/shopify'
    alias scw='spin code -l shop--world//areas/clients/checkout-web'
    alias scpw='spin code -l shopify--portable-wallets'
    alias so='spin open'
    alias sol='spin open -l'
    alias ss='spin shell'
    alias ssl='spin shell -l'
fi

alias br='bin/rails'

