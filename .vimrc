" Solarized theme
syntax enable
set background=dark
colorscheme solarized

set tabstop=3       " number of visual spaces per TAB
set softtabstop=3   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=3    " >> and << shift 3 spaces

set number          " show line numbers
filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set showmatch       " highlight matching [{()}]

set incsearch       " search as characters are entered
set hlsearch        " highlight matches

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" alternatives to escape key
inoremap jk <Esc>
inoremap kj <Esc>

" Live dangerously
set nowritebackup
set nobackup
set noswapfile
