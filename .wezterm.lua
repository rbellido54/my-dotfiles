local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Dark themes
-- config.color_scheme = "Catppuccin Frappe"
config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Everforest Dark Medium (Gogh)" -- nightly
-- config.color_scheme = "Everforest Dark Soft (Gogh)" -- nightly
-- config.color_scheme = "Nova (base16)"
-- config.color_scheme = "Obsidian (Gogh)"
-- config.color_scheme = "PaleNightHC"
-- config.color_scheme = "Palenight (Gogh)"
-- config.color_scheme = "Pali (Gogh)"
-- config.color_scheme = "Poimandres Storm"
-- config.color_scheme = "Poimandres"
-- config.color_scheme = "Ryuuko"
-- config.color_scheme = "Seafoam Pastel"
-- config.color_scheme = "Slate (Gogh)"
-- config.color_scheme = "Spacegray Eighties (Gogh)"

-- Light themes for quick switching
-- config.color_scheme = "Catppuccin Latte"
-- config.color_scheme = "One Light (Gogh)"
-- config.color_scheme = "OneHalfLight"
-- config.color_scheme = "Papercolor Light (Gogh)"
-- config.color_scheme = "rose-pine-dawn"
-- config.color_scheme = "Tomorrow"

config.font = wezterm.font("MesloLGL Nerd Font Mono", { weight = "DemiBold" })
config.font_size = 13.0
config.line_height = 1.1

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.97
config.macos_window_background_blur = 10
config.window_padding = {
	left = 5,
	right = 5,
	top = 0,
	bottom = 0,
}

return config
