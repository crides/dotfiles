local wezterm = require 'wezterm'
return {
    font = wezterm.font "Iosevka Term",
    font_size = 10,
    enable_scroll_bar = false,
    color_scheme = "Gruvbox dark, hard (base16)",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    adjust_window_size_when_changing_font_size = false,
}
