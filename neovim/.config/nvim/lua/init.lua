local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup {}
nvim_lsp.psalm.setup {
   flags = {
      -- Wait 5 seconds before sending didChange
      debounce_text_changes = 5000,
   }
}
nvim_lsp.eslint.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

--- Linter setup
local filetypes = {
  -- typescript = "eslint",
  -- typescriptreact = "eslint",
  -- python = "flake8",
  php = {"phpcs", "psalm"},
}

local linters = {
  -- eslint = {
  --   sourceName = "eslint",
  --   command = "./node_modules/.bin/eslint",
  --   rootPatterns = {".eslintrc.js", "package.json"},
  --   debouce = 100,
  --   args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
  --   parseJson = {
  --     errorsRoot = "[0].messages",
  --     line = "line",
  --     column = "column",
  --     endLine = "endLine",
  --     endColumn = "endColumn",
  --     message = "${message} [${ruleId}]",
  --     security = "severity"
  --   },
  --   securities = {[2] = "error", [1] = "warning"}
  -- },
  -- flake8 = {
  --   command = "flake8",
  --   sourceName = "flake8",
  --   args = {"--format", "%(row)d:%(col)d:%(code)s: %(text)s", "%file"},
  --   formatPattern = {
  --     "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
  --     {
  --         line = 1,
  --         column = 2,
  --         message = {"[", 3, "] ", 5},
  --         security = 4
  --     }
  --   },
  --   securities = {
  --     E = "error",
  --     W = "warning",
  --     F = "info",
  --     B = "hint",
  --   },
  -- },
  phpcs = {
    command = "vendor/bin/phpcs",
    sourceName = "phpcs",
    debounce = 300,
    rootPatterns = {"composer.lock", "vendor", ".git"},
    args = {"--report=emacs", "-s", "-"},
    offsetLine = 0,
    offsetColumn = 0,
    sourceName = "phpcs",
    formatLines = 1,
    formatPattern = {
      "^.*:(\\d+):(\\d+):\\s+(.*)\\s+-\\s+(.*)(\\r|\\n)*$",
      {
        line = 1,
        column = 2,
        message = 4,
        security = 3
      }
    },
    securities = {
      error = "error",
      warning = "warning",
    },
    requiredFiles = {"vendor/bin/phpcs"}
  },
  -- psalm = {
  --   command = "./vendor/bin/psalm",
  --   sourceName = "psalm",
  --   debounce = 100,
  --   rootPatterns = {"composer.lock", "vendor", ".git"},
  --   args = {"--output-format=emacs", "--no-progress"},
  --   offsetLine = 0,
  --   offsetColumn = 0,
  --   sourceName = "psalm",
  --   formatLines = 1,
  --   formatPattern = {
  --     "^[^ =]+ =(\\d+) =(\\d+) =(.*)\\s-\\s(.*)(\\r|\\n)*$",
  --     {
  --       line = 1,
  --       column = 2,
  --       message = 4,
  --       security = 3
  --     }
  --   },
  --   securities = {
  --     error = "error",
  --     warning = "warning"
  --   },
  --   requiredFiles = {"vendor/bin/psalm"}
  -- }
}

-- local formatters = {
--   phpcbf = {
--   	 command = "vendor/bin/phpcbf",
--   	 rootPatterns = {"composer.lock", "vendor", ".git"},
--   	 args = {"-"},
--   	 isStdout = true,
--   	 isStderr = false,
--   	 doesWriteToFile = false,
--   	 ignoreExitCode = {1},
--     requiredFiles = {"vendor/bin/phpcbf"}
--   }
-- }

-- nvim_lsp.diagnosticls.setup {
--   filetypes = vim.tbl_keys(filetypes),
--   init_options = {
--     -- filetypes = filetypes,
--     linters = linters,
--     formatters = {}
--   },
-- }

--
-- lualine
--
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
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
        sources = { 'nvim_lsp' },

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

require('lint').linters_by_ft = {
  php = {'phpcs', 'php'}
}

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.phpcbf,
    },
})
