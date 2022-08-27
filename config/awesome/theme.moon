theme_assets = require "beautiful.theme_assets"
xresources = require "beautiful.xresources"
dpi = xresources.apply_dpi
colors = xresources.get_current_theme!

gfs = require "gears.filesystem"
themes_path = gfs.get_themes_dir!
taglist_square_size = dpi 4
font = "Iosevka Term"
HOME = os.getenv("HOME")

with {}
    .font = font .. " 10"
    .hotkeys_font = font .. " Italic 9"
    .hotkeys_description_font = font .. " Italic 9"

    .background     = colors.background
    .foreground     = colors.foreground
    .black          = colors.color0
    .red            = colors.color1
    .green          = colors.color2
    .yellow         = colors.color3
    .blue           = colors.color4
    .magenta        = colors.color5
    .cyan           = colors.color6
    .lightgray      = colors.color7

    .darkgray       = colors.color8
    .bright_red     = colors.color9
    .bright_green   = colors.color10
    .bright_yellow  = colors.color11
    .bright_blue    = colors.color12
    .bright_magenta = colors.color13
    .bright_cyan    = colors.color14
    .white          = colors.color15

    .bg_normal = .black
    .bg_focus = .darkgray
    .bg_urgent = .red
    .bg_minimize = .black
    .bg_systray = .bg_normal
    .hotkeys_modifiers_fg = .lightgray

    .fg_normal = .lightgray
    .fg_focus = .white
    .fg_urgent = .white
    .fg_minimize = .white

    .useless_gap = dpi 0
    .border_width = dpi 0
    .border_normal = .black
    .border_focus = .darkgray
    .border_marked = .red

    .tooltip_bg = .black

    .taglist_bg_focus = .cyan
    .taglist_fg_focus = .black
    .taglist_bg_normal = .black
    .taglist_fg_normal = .lightgray

    .tasklist_bg_focus = .cyan
    .tasklist_fg_focus = .black
    .tasklist_bg_normal = .black
    .tasklist_fg_normal = .lightgray
    .tasklist_bg_minimize = .darkgray
    .tasklist_plain_task_name = true

    .apw_fg_normal = .black
    .apw_bg_normal = .green
    .apw_bg_mute = .red

    .notification_max_height = dpi 10000
    .notification_icon_size = dpi 72

    .menu_submenu_icon = themes_path.."default/submenu.png"
    .menu_height = dpi 15
    .menu_width = dpi 100

    -- Define the image to load
    titlebar_img = => "#{themes_path}default/titlebar/#{@}.png"
    .titlebar_close_button_normal = titlebar_img("close_normal")
    .titlebar_close_button_focus = titlebar_img("close_focus")

    .titlebar_minimize_button_normal = titlebar_img("minimize_normal")
    .titlebar_minimize_button_focus = titlebar_img("minimize_focus")

    .titlebar_ontop_button_normal_inactive = titlebar_img("ontop_normal_inactive")
    .titlebar_ontop_button_focus_inactive = titlebar_img("ontop_focus_inactive")
    .titlebar_ontop_button_normal_active = titlebar_img("ontop_normal_active")
    .titlebar_ontop_button_focus_active = titlebar_img("ontop_focus_active")

    .titlebar_sticky_button_normal_inactive = titlebar_img("sticky_normal_inactive")
    .titlebar_sticky_button_focus_inactive = titlebar_img("sticky_focus_inactive")
    .titlebar_sticky_button_normal_active = titlebar_img("sticky_normal_active")
    .titlebar_sticky_button_focus_active = titlebar_img("sticky_focus_active")

    .titlebar_floating_button_normal_inactive = titlebar_img("floating_normal_inactive")
    .titlebar_floating_button_focus_inactive = titlebar_img("floating_focus_inactive")
    .titlebar_floating_button_normal_active = titlebar_img("floating_normal_active")
    .titlebar_floating_button_focus_active = titlebar_img("floating_focus_active")

    .titlebar_maximized_button_normal_inactive = titlebar_img("maximized_normal_inactive")
    .titlebar_maximized_button_focus_inactive = titlebar_img("maximized_focus_inactive")
    .titlebar_maximized_button_normal_active = titlebar_img("maximized_normal_active")
    .titlebar_maximized_button_focus_active = titlebar_img("maximized_focus_active")

    .wallpaper = HOME .. "/Pictures/wallpapers/keeb.jpg"

    -- You can use your own layout icons like this:
    layout_icon = => "#{themes_path}default/layouts/#{@}.png"
    .layout_fairh = layout_icon("fairhw")
    .layout_fairv = layout_icon("fairvw")
    .layout_floating = layout_icon("floatingw")
    .layout_magnifier = layout_icon("magnifierw")
    .layout_max = layout_icon("maxw")
    .layout_fullscreen = layout_icon("fullscreenw")
    .layout_tilebottom = layout_icon("tilebottomw")
    .layout_tileleft = layout_icon("tileleftw")
    .layout_tile = layout_icon("tilew")
    .layout_tiletop = layout_icon("tiletopw")
    .layout_spiral = layout_icon("spiralw")
    .layout_dwindle = layout_icon("dwindlew")
    .layout_cornernw = layout_icon("cornernww")
    .layout_cornerne = layout_icon("cornernew")
    .layout_cornersw = layout_icon("cornersww")
    .layout_cornerse = layout_icon("cornersew")

    -- Generate Awesome icon:
    .awesome_icon = theme_assets.awesome_icon .menu_height, .bg_focus, .fg_focus

    -- Define the icon theme for application icons. If not set then the icons
    -- from /usr/share/icons and /usr/share/icons/hicolor will be used.
