local config = wezterm.config_builder()

config.enable_wayland = false

config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.color_scheme = 'Gruvbox Material (Gogh)'
config.window_background_opacity = 0.6
config.text_background_opacity = 0.4

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 11
config.freetype_load_target = "HorizontalLcd"

return config
