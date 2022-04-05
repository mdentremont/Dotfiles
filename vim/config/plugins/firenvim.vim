au BufEnter github.com_*.txt set filetype=markdown

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {},
    \ },
\ }

let fc = g:firenvim_config['localSettings']
let fc['.*'] = { 'cmdline': 'firenvim', 'content': 'text', 'priority': 0, 'takeover': 'never' }
