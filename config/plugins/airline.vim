" For now only enable powerline font on non-Windows machines
if MySys() == "linux"
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    let g:airline_powerline_fonts=1
elseif MySys() == "mac"
    set guifont=Menlo\ Regular\ for\ Powerline:h11
    let g:airline_powerline_fonts=1
endif

