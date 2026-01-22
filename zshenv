#!/bin/zsh


fpath=(~/.oh-my-zsh/completions $fpath)
path=(
    $HOME/bin
    /usr/local/bin
    $path
)

export LESS='-I -R'

export PATH
