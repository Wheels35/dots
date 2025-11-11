local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config = {
color_scheme = 'Catppuccin Mocha',
font_size = 16,
default_cursor_style = 'BlinkingBar',
window_decorations = "RESIZE",

}
return config
