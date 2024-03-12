local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Gruvbox Material (Gogh)'
config.integrated_title_button_style = "Gnome"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font 'FiraCode'
config.font_size = 11.25

return config