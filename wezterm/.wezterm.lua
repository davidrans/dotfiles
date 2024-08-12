local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Gruvbox Material (Gogh)'

config.keys = {
  -- paste from the primary selection
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
  -- paste from the clipboard
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make issue/pull numbers clickable
table.insert(config.hyperlink_rules, {
  regex = [[#(\d{2,})]],
  format = 'https://github.com/iFixit/ifixit/issues/$1',
})

return config
