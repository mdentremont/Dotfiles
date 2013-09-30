" Do not show the "Load?" dialog for YouCompleteMe
let g:ycm_confirm_extra_conf = 0

" Stolen from
" https://github.com/rygwn/vimfiles/blob/master/conf.d/setup-paths-using-ycm.vim
python << EOF
def SetupPathFromYCM():
    try:
        import ycm.completers.cpp.flags
    except:
        pass
    else:
        flags = ycm.completers.cpp.flags.Flags()
        pathstr = ",".join(flags.UserIncludePaths(vim.current.buffer.name))
        vim.current.buffer.options["path"] = pathstr
EOF

command! SetupPathFromYCM python SetupPathFromYCM()
