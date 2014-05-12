#!/bin/zsh

# Platform dependent configs
if [[ `uname` == 'Darwin' ]]
then
    source /opt/boxen/env.sh

    [ -d "$ANDROID_HOME" ] && path+=("$ANDROID_HOME/platform-tools")
fi

# Place at start of path
[ -d "$HOME/bin" ] &&  path=($HOME/bin $path)

local AIO_TV_DEV_NOTES="$HOME/git/aioTV-dev-notes/bin"
if [ -d $AIO_TV_DEV_NOTES ]
then path+=($AIO_TV_DEV_NOTES)
fi

export PATH

