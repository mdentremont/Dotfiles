# ZSH aliases

if [[ `uname` != 'Darwin' ]]
then
    alias ls='ls --color'
fi
alias o='open "$@"'

if hash ember 2>/dev/null; then
    alias e='ember'
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

    alias gg="/mnt/c/Program\ Files/Git/cmd/git-gui.exe &"

    alias gl="git l"

    alias glp="git lp"

    alias gs="git status -sb"

    function git_cleanup_branches {
        git fetch && git_merged_branches | cut -d/ -f2- | xargs -r -n 1 git branch -D
    }

    function git_cleanup_remote_branches {
        git fetch && git_merged_branches -r | sed -e 's|^origin/||' | xargs --no-run-if-empty --max-args=1 git push origin --delete
    }

    function get_remote_target_branches {
        git for-each-ref --format='%(refname)' refs/remotes/origin/bugfix refs/remotes/origin/utilities refs/remotes/origin/rc refs/remotes/origin/feature/ refs/remotes/origin/hotfix/ refs/remotes/origin/rc/ refs/remotes/origin/bugfixdrop 2>&/dev/null | sed 's|^refs/remotes/origin/||'
    }

    function git_merged_branches {
        refs="${1:-refs/heads}"
        [[ "$refs" == "-r" ]] && refs="refs/remotes/"
        get_remote_target_branches | while read target_branch
        do
            git for-each-ref --format='%(refname:short)' "--merged=origin/$target_branch" $refs 2>&/dev/null
        done | sort -u | grep -vE '(^|/)(rc/.*|bugfix|bugfixdrop|feature/.*|production|master|rc|translations|utilities)$'
    }

    function git_cleanup_old_branches {
        git fetch
        for branch in $(git branch -r --no-merged origin/production | cut -d/ -f2- | grep -v -e '^production' -e '^bugfix' -e '^itk-release' -e '^utilities' -e '^feature' -e '^hotfix_' -e '^qa-drop'); do
            if [ -z "$(git log -1 --since='6 month ago' -s origin/$branch)" ]; then
                git push --delete origin $branch
            fi
        done
    }

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

alias src="cd /mnt/c/Users/matt.dentremont/git/intellitrack-service"
alias rel="cd /mnt/c/Users/matt.dentremont/git/intellitrack-service-release"

function rm_dangling_docker() {
    docker volume rm ${docker volume ls -qf dangling=true}
}

