" Do not show the "Load?" dialog for YouCompleteMe
let g:ycm_confirm_extra_conf = 0

" REMOVE ON WINDOWS FOR NOW
" Hardcode python path to prevent YCM from failing in virtualenvs
"let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'

" Use enter to do a YCM GoTo when in normal mode
autocmd FileType python nnoremap <buffer> <CR> :YcmCompleter GoTo<CR>

" Stolen from
" https://github.com/rygwn/vimfiles/blob/master/conf.d/setup-paths-using-ycm.vim
"if index(keys(g:plugs), 'YouCompleteMe') == -1
    "finish
"endif

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
