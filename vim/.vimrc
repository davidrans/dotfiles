syntax enable
set background=dark
colorscheme gruvbox

set tabstop=3       " number of visual spaces per TAB
set softtabstop=3   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=3    " >> and << shift 3 spaces
set autoindent
set smartindent

set number          " show line numbers
filetype plugin indent on  " load filetype-specific indent files

set wildmenu        " visual autocomplete for command menu
set showmatch       " highlight matching [{()}]

set gdefault        " assume :s uses /g
set ignorecase      " ignore case in search patterns
set smartcase       " searches are case-sensitive if caps used
set incsearch       " search as characters are entered
set hlsearch        " highlight matches

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" alternatives to escape key
inoremap jk <Esc>
inoremap kj <Esc>
" Allows w!! to write the file using sudo
cmap w!! w !sudo tee >/dev/null %

"pman - php man pages.
command! -nargs=1 DashtCursor :call Dasht(<q-args>)
set keywordprg=:DashtCursor

" Live dangerously
set nowritebackup
set nobackup
set noswapfile

" ignore irrelevant files when searching
set wildignore+=*.log
set wildignore+=**/.git/**
set wildignore+=**/node_modules/**
set wildignore+=**/vendor/**

" Use FZF plugin
nnoremap <C-a> :Files<CR>
nnoremap <C-g> :Rg<CR>
