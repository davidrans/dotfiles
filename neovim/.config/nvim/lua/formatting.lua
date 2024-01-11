-- Formatters
-- Formatting can be run via :Format
local formatter = require('formatter')

formatter.setup {
  logging = true,
  filetype = {
    php = {
      function ()
        return {
          exe = './vendor/bin/phpcbf',
          args = {'--stdin-path=' .. vim.api.nvim_buf_get_name(0), '-'},
          stdin = true,
          ignore_exitcode = true,
        }
      end
    }
  }
}

vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
