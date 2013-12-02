fun! MySys()
    if has("mac")
        return "mac"
    elseif has("unix")
        return "linux"
    elseif has("win32")
        return "windows"
    endif

    return "unknown"
endfun

set runtimepath=~/.vim,$VIMRUNTIME
source ~/.vim/vimrc
