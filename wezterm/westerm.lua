local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.background = {
	{
		source = {
			File = "/home/strbagus/Pictures/Random/yujin-ive.jpg",
		},
    horizontal_align = "Center",
    hsb = { brightness = 0.1 }
	}
}
return config
