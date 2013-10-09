" For now only enable powerline font on non-Windows machines
if !has("win32") && !has("win64")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    let g:airline_powerline_fonts=1
endif

