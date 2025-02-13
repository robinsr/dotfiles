-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Purple Rain'
config.font_size = 15
config.line_height = 1.1
config.window_background_opacity = 0.9
config.window_padding = {
  left = 2,
  right = 2,
  top = 10,
  bottom = 10,
}

-- and finally, return the configuration to wezterm
return config
