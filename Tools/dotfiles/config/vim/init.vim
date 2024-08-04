" Neivim config fili
" Piblished on Github: ValentinMENDIss



"VISUALS"

set number	"Show line numbers"

set nowrap	"Do not wrap lines"

syntax on	"Enable syntax highlightning "

set cursorline  "Highlight the line where the cursor is"

set foldmethod=manual   "(Fold what you don't need now)'zr' = read/open; 'zf' = fold"

"STATUS LINE"
set statusline=%F "Configuring Status Line"
set statusline+=%{&modified?'[+]':''}
set statusline+=\ %{toupper(g:currentmode[mode()])}


let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}



"THEME"
colorscheme slate



"INPUT"

set tabstop=4   "Spaces left after 'TAB' is pressed" 

set softtabstop=4   "Delete Spaces by 4 ('Characters')"

set autoindent  "Indent next line to the same level (Useful for aligning code)"

set expandtab	"Insert Spaces instead of Tabs (The benefit of spaces is avoiding alignment irregularities when mixing tabs and spaces. Stick with spaces for consistent results.)"


"SEARCH"
set incsearch       " Incremental searching



"REMAP KEYS"

map jj <Esc>    " Map 'jj' to 'ESC' "

"Change leader key"
let mapleader = ","


"Quit: with leader key + q"
map <leader>q :q<CR>   

"Write: with leader key + w"
map <leader>w :w<CR>   





