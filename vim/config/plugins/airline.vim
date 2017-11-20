" For now only enable powerline font on non-Windows machines
if has("unix")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    let g:airline_powerline_fonts=1
elseif has("macunix")
    set guifont=Monaco\ for\ Powerline:h11
    let g:airline_powerline_fonts=1
endif

let g:airline_theme='wombat'

