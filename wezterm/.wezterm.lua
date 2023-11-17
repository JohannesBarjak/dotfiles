local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

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

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "Gnome"
config.integrated_title_buttons = { 'Close' }

config.color_scheme = 'Gruvbox Material (Gogh)'

return config
