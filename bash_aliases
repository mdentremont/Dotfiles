# Bash aliases
alias ls='ls --color'
alias o='open "$@"'
alias bdt-ssh='bdt -CLI -r "SSH" --rtasUser="mdentremont"'

# Use apt-fast if it exists
if hash apt-fast 2>/dev/null; then
    alias apt-get="apt-fast"
fi

function gv { ( gvim -f "$@" & ) &>/dev/null ; }
#complete -r gv 

# Git aliases
alias g="git"
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

alias gb="git b"
complete -o bashdefault -o default -o nospace -F __git_branch gb

alias gd="git diff"
complete -o bashdefault -o default -o nospace -F __git_diff gd

alias gdc="git diff --cached"
complete -o bashdefault -o default -o nospace -F __git_diff gdc

alias gg="git gui&"

alias gl="git l"
complete -o bashdefault -o default -o nospace -F __git_log gl

alias glp="git lp"
complete -o bashdefault -o default -o nospace -F __git_log glp

alias gs="git status"
complete -o bashdefault -o default -o nospace -F __git_status gs

gmod () {
    path=$(git rev-parse --show-toplevel || pwd)
    [[ -z "$1" ]] && files="$(cd $path ; git status --porcelain | sed 's/^ *[^ ]* *//' | sort -u)"
    [[ -z $files ]] && files="$(cd $path; git diff-tree --no-commit-id --name-only -r ${1:-HEAD})"
    files=$(echo "$files" | sed "s!^!$path/!" | grep -v '/images/' | while read line ; do file "$line" | grep -q '\btext\b' && echo $line ; done)
    gv $(echo "$files" | xargs echo)
}
