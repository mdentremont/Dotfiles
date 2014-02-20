#!/bin/zsh

# Platform dependent configs
if [[ `uname` == 'Darwin' ]]
then
    local ADT_LOCATION="$HOME/development/adt-bundle-mac-x86_64-20131030/sdk/platform-tools"
    if [ -d "$ADT_LOCATION" ]
    then
        # Add android SDK to path if it exists
        path+=("$ADT_LOCATION")
    fi
fi

if [ -d "$HOME/bin" ]
then
    # Place at start of path
    path=($HOME/bin $path)
fi

local AIO_TV_DEV_NOTES="$HOME/git/aioTV-dev-notes/bin"
if [ -d $AIO_TV_DEV_NOTES ]
then path+=($AIO_TV_DEV_NOTES)
fi

export PATH

