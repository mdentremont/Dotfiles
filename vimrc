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

if !has("nvim")
    source  ~/.config/nvim/init.vim
endif
