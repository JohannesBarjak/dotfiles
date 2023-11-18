local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Use zsh as my shell
config.default_prog = { '/usr/bin/zsh', '-l' }

config.font = wezterm.font
    { family = 'Fira Code'
    }

config.harfbuzz_features = { 'ss02', 'ss09', 'cv29' }

config.window_padding =
    { left = 4
    , right = 4
    , top = 8
    , bottom = 8
    }

config.window_decorations = "NONE|RESIZE"
config.enable_tab_bar = false

config.color_scheme = 'Gruvbox Material (Gogh)'

return config
