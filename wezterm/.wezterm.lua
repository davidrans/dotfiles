local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Gruvbox Material (Gogh)'

config.keys = {
  -- paste from the primary selection
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
  -- paste from the clipboard
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
  },
  { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
  },
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make issue/pull numbers clickable
table.insert(config.hyperlink_rules, {
  regex = [[#(\d{2,})]],
  format = 'https://github.com/iFixit/ifixit/issues/$1',
})

-- Turn off ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.selection_word_boundary = " │\t\n{}[]()\"'`|"

return config
