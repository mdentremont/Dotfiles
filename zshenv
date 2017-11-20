#!/bin/zsh

# Needed for zplug reload to succeed
#set -x

function remove_entry_from_path {
    path[${path[(i)$1]}]=()
}

remove_entry_from_path '/mnt/c/Program Files/nodejs'

path=(
    $HOME/bin
    $path
)


export FRP='/mnt/c/Users/matt.dentremont/bin/frp/'

export PATH
