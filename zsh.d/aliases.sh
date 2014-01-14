# ZSH aliases

if [[ `uname` != 'Darwin' ]]
then
    alias ls='ls --color'
fi
alias o='open "$@"'

# Use apt-fast if it exists
if hash apt-fast 2>/dev/null; then
    alias apt-get="apt-fast"
fi

# Fix ag colours
alias ag='ag --color-line="0;33" --color-path="0;32"'

# Only set git aliases if git exists
if hash git 2>/dev/null; then
    function gv { ( gvim -f "$@" & ) &>/dev/null ; }
    compdef gv=gvim

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

    alias gg="git gui&"

    alias gl="git l"

    alias glp="git lp"

    alias gs="git status -sb"

    function gmod {
        local _path=$(git rev-parse --show-toplevel || pwd)
        local _files=

        # changed files
        #echo "1: $1"
        [[ -z "$1" ]] && _files="$(cd $_path ; git status --porcelain | sed 's/^ *[^ ]* *//' | sort -u)"
        #echo "f1: $_files"

        # files changed in HEAD
        [[ -z $_files ]] && _files="$(cd $_path; git diff-tree --no-commit-id --name-only -r ${1:-HEAD})"
        #echo "f2: $_files"
        _files=$(echo "$_files" | sed "s!^!$_path/!" | grep -v '/images/' | while read line ; do file "$line" | grep -q '\btext\b' && echo $line ; done)
        #echo "f3: $_files"

        gv $(echo "$_files" | xargs echo)
    }
fi

