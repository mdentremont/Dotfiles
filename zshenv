#!/bin/zsh

function remove_entry_from_path {
    path[${path[(i)$1]}]=()
}

remove_entry_from_path '/mnt/c/Program Files/nodejs'

fpath=(~/.oh-my-zsh/completions $fpath)
path=(
    $HOME/bin
    /usr/local/bin
    $path
)


export LESS='-I -R'

export PATH
