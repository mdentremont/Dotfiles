" Use comma as the leader
let mapleader=","
let g:mapleader=","

" Treat Y like other capitals (operate to end of line)
map Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" <leader>p to toggle paste mode
noremap <leader>p :setlocal paste! paste?<cr>

map ; :
noremap ;; ;
noremap :: ,

" Support Alt on VIM terminals {{{
"if !has('gui_running') && has('nvim')
"    let c='a'
"    while c <= 'z'
"      exec "set <A-".c.">=\e".c
"      exec "imap \e".c." <A-".c.">"
"      let c = nr2char(1+char2nr(c))
"    endw
"
"    set timeout ttimeoutlen=50
"endif
" }}}

if !exists('g:vscode')
" F key mappings {{{
    nnoremap <F5> :GundoToggle<CR>
    nnoremap <F4> :TagbarToggle<CR>
    nnoremap <F3> :NERDTreeToggle<CR>
" }}}
endif

" Fast saving {{{
nmap <leader>w :w<cr>
" }}}

" Fast editing of vimrc {{{
map <leader>e :e! ~/.config/nvim/init.vim<cr>
" }}}

"" CTRL-X and SHIFT-Del are Cut
"vnoremap <C-X> "+x
"vnoremap <S-Del> "+x

"" CTRL-C and CTRL-Insert are Copy
"vnoremap <C-C> "+y
"vnoremap <C-Insert> "+y

"" CTRL-V and SHIFT-Insert are Paste
"map <C-V> "+gP
"map <S-Insert> "+gP
"cmap <C-V> <C-R>+
"cmap <S-Insert> <C-R>+

"" Pasting blockwise and linewise selections is not possible in Insert and
"" Visual mode without the +virtualedit feature.  They are pasted as if they
"" were characterwise instead.
"" Uses the paste.vim autoload script.
"exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
"exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

"imap <S-Insert> <C-V>
"vmap <S-Insert> <C-V>

"" Use CTRL-Q to do what CTRL-V used to do
"noremap <C-Q> <C-V>

" Disable Ex Mode
nnoremap Q :

" Disable Search Highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Move around windows
" Note: tmux split plugin takes care of these now
"nnoremap <C-l> l
"nnoremap <C-h> h
"nnoremap <C-k> k
"nnoremap <C-j> j
"map <C-a> 

" Switch tabs
" Note: I don't think I've ever used vim tabs, disabling for now so <C-T> can
"       be used for indenting
"nmap <C-S-tab> :tabprevious<cr>
"nmap <C-tab> :tabnext<cr>
"nmap <C-t> :tabnew<cr>
"map <C-t> :tabnew<cr>
"map <C-S-tab> :tabprevious<cr>
"map <C-tab> :tabnext<cr>
"imap <C-S-tab> <ESC>:tabprevious<cr>i
"imap <C-tab> <ESC>:tabnext<cr>i
"imap <C-t> <ESC>:tabnew<cr>

" Tab configuration
"map <leader>tn :tabnew<cr>
"map <leader>te :tabedit
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" CtrlP buffer list
if !exists('g:vscode')
    nnoremap <Space> :CtrlPBuffer<CR>
endif

" Search for current selection on * or #
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Press gv to vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern . "^M")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Arrow key remapping:
" Up/Alt+j and Down/Alt+k = move line up/dn
" Left/Alt+h and Right/Alt+l = indent/unindent
" Note: Alt combos are set by the vim-move plugin

" Normal mode
nnoremap <silent> <Left> <<
nnoremap <silent> <A-h> <<
nnoremap <silent> <Right> >>
nnoremap <silent> <A-l> >>
nmap <silent> <Up> <Plug>MoveLineUp
nmap <silent> <Down> <Plug>MoveLineDown

" Visual mode
vnoremap <silent> <Left> <gv
vnoremap <silent> <A-h> <gv
vnoremap <silent> <Right> >gv
vnoremap <silent> <A-l> >gv
vmap <silent> <Up> <Plug>MoveBlockUp
vmap <silent> <Down> <Plug>MoveBlockDown

" Insert mode
inoremap <silent> <Left> <C-D>
inoremap <silent> <Right> <C-T>
imap <silent> <Up> <Plug>MoveLineUp
imap <silent> <Down> <Plug>MoveLineDown
