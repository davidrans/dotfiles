set tabstop=3       " number of visual spaces per TAB
set softtabstop=3   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=3    " >> and << shift 3 spaces
set autoindent
set smartindent
filetype plugin indent on  " load filetype-specific indent files

set number          " show line numbers

set gdefault        " assume :s uses /g
set ignorecase      " ignore case in search patterns
set smartcase       " searches are case-sensitive if caps used
set incsearch       " search as characters are entered
set hlsearch        " highlight matches

set wildmenu        " visual autocomplete for command menu
set showmatch       " highlight matching [{()}]

set mouse=          " disable mouse

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" alternatives to escape key
inoremap jk <Esc>
inoremap kj <Esc>
" Allows w!! to write the file using sudo
cmap w!! w !sudo tee >/dev/null %

nnoremap O :ALEGoToDefinition<CR>

" Live dangerously
set nowritebackup
set nobackup
set noswapfile

syntax enable

"
" Theme Settings
"
if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'medium'

" For better performance
let g:gruvbox_material_better_performance = 1

" `material`: Carefully designed to have a soft contrast.
" `mix`: Color palette obtained by calculating the mean of the other two.
" `original`: The color palette used in the original gruvbox.
let g:gruvbox_material_foreground = 'mix'

colorscheme gruvbox-material

"
" ALE
"
let g:ale_linters_ignore = {
\   'javascript': ['jshint'],
\   'javascriptreact': ['jshint'],
\   'typescript': ['jshint'],
\   'typescriptreact': ['jshint'],
\}

let g:ale_linters = {
\   'php': ['php', 'phpcs', 'psalm'],
\}

let g:psalm_langserver_options = "--threads=2"

let g:ale_fixers = {
\   'php': ['phpcbf'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'css': ['prettier'],
\   'json': ['prettier'],
\}

" If I don't do this, phpcbf fails on any file in the exclude-pattern :/
let g:ale_php_phpcbf_executable = $HOME.'/phpcbf-helper.sh'
" in order to get the alternate executable working you have to declare it as
" use global, even though it's not 'global' :/
let g:ale_php_phpcbf_use_global = 1

let g:ale_fix_on_save = 1

"
" FZF
"
set rtp+=~/.fzf
nnoremap <C-a> :Files<CR>
nnoremap <C-g> :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"
" lualine
"
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff'},
    lualine_c = {
      {
        'diagnostics',

        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'ale' },

        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      },
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = false,  -- Display new file status (new file means no write after created)
        path = 1,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path
                                 -- 3: Absolute path, with tilde as the home directory

        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                 -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for new created file before first writting
        }
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

command! -nargs=1 DashtCursor :call Dasht(<q-args>)
set keywordprg=:DashtCursor
