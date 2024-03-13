local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Gruvbox Material (Gogh)'
config.integrated_title_button_style = "Gnome"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 11.25
config.freetype_load_target = "HorizontalLcd"

return config
