#!/bin/zsh

# Platform dependent configs
if [[ `uname` == 'Darwin' ]]
then
    [[ -d "/opt/boxen/env.sh" ]] && source /opt/boxen/env.sh

    [[ -d "$ANDROID_HOME" ]] && path+=("$ANDROID_HOME/platform-tools")
fi

# Place at start of path
[ -d "$HOME/bin" ] && path=($HOME/bin $path)

local AIO_TV_DEV_NOTES="$HOME/git/aioTV-dev-notes/bin"
[[ -d $AIO_TV_DEV_NOTES ]] && path+=($AIO_TV_DEV_NOTES)

export PATH

