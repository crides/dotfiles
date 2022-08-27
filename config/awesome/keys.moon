naughty = require "naughty"
gears = require "gears"
awful = require "awful"
hotkeys_popup = require "awful.hotkeys_popup"
require "util"
modkey = "Mod4"
xrandr = require "xrandr"

term = "alacritty"
-- new_term = full_path "new_term.sh"
new_term = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
HOME = os.getenv("HOME")
editor_cmd = term .. " -e " .. editor
browser = HOME .. "/gitproj/qutebrowser/qutebrowser.py"

lockscreen = -> awful.util.spawn(HOME .. "/.local/bin/lock manual")

keys = gears.table.join(
    awful.key(
        { modkey, "Ctrl"    }, "l",      lockscreen,
        {description: "show help", group: "awesome"}),
    awful.key(
        { modkey,           }, "s",      hotkeys_popup.show_help,
        {description: "show help", group: "awesome"}),
    awful.key(
        { modkey,           }, "Left",   awful.tag.viewprev,
        {description: "view previous", group: "tag"}),
    awful.key(
        { modkey,           }, "Right",  awful.tag.viewnext,
        {description: "view next", group: "tag"}),
    awful.key(
        { modkey,           }, "Escape", awful.tag.history.restore,
        {description: "go back", group: "tag"}),
    awful.key(
        { modkey,           }, "h", -> awful.client.focus.byidx(-1),
        {description: "focus previous by index", group: "client"}),
    awful.key(
        { modkey,           }, "l", -> awful.client.focus.byidx(1),
        {description: "focus next by index", group: "client"}),
    awful.key(
        { modkey, "Shift"   }, "h", -> awful.client.swap.byidx( -1),
        {description: "swap with previous client by index", group: "client"}),
    awful.key(
        { modkey, "Shift"   }, "l", -> awful.client.swap.byidx(  1),
        {description: "swap with next client by index", group: "client"}),
    awful.key(
        { modkey,           }, "j", -> awful.screen.focus_relative(-1),
        {description: "focus the next screen", group: "screen"}),
    awful.key(
        { modkey,           }, "k", -> awful.screen.focus_relative( 1),
        {description: "focus the previous screen", group: "screen"}),
    awful.key(
        { modkey,           }, "u", awful.client.urgent.jumpto,
        {description: "jump to urgent client", group: "client"}),

    awful.key(    -- Standard program
        { modkey,           }, "Return", -> awful.spawn(new_term),
        {description: "open a terminal", group: "launcher"}),
    awful.key(
        { modkey,           }, "f", -> awful.spawn(browser),
        {description: "open a terminal", group: "launcher"}),
    awful.key(
        { modkey, "Shift"   }, "r", awesome.restart,
        {description: "reload awesome", group: "awesome"}),
    awful.key(
        { modkey, "Shift"   }, "q", awesome.quit,
        {description: "quit awesome", group: "awesome"}),
    awful.key(
        { modkey,           }, "space", -> awful.layout.inc( 1),
        {description: "select next", group: "layout"}),
    awful.key(
        { modkey, "Shift"   }, "space", -> awful.layout.inc(-1),
        {description: "select previous", group: "layout"}),

    awful.key(
        { modkey },            "d",     -> os.execute("rofi -show drun"),
        {description: "rofi apps", group: "launcher"}),
    awful.key(
        { modkey },            "w",     -> os.execute("rofi -show window"),
        {description: "rofi windows", group: "launcher"}),
    awful.key(
        { modkey, "Shift" },   "d",     -> os.execute("rofi -show run"),
        {description: "rofi commands", group: "launcher"}),

    awful.key(      -- Multimedia keys
        { }, "Print", -> os.execute full_path "screenshot",
        {description: "Take screenshot of the whole screen", group: "multimedia"}),
    awful.key(
        { "Shift" }, "Print", -> os.execute full_path("screenshot") .. " -s",
        {description: "Take screenshot with interactive selection", group: "multimedia"}),
    awful.key(
        { "Mod1" }, "Print", -> os.execute full_path("screenshot") .. " -st 9999999",
        {description: "Take screenshot with interactive selection, auto snap", group: "multimedia"}),
    awful.key(
        { }, "XF86MonBrightnessUp", -> os.execute "xbacklight -inc 5",
        {description: "Increase brightness", group: "multimedia"}),
    awful.key(
        { }, "XF86MonBrightnessDown", -> os.execute "xbacklight -dec 5",
        {description: "Decrease brightness", group: "multimedia"}),

    awful.key(
        { }, "XF86AudioRaiseVolume", -> APW\up!,
        {description: "Increase volume", group: "multimedia"}),
    awful.key(
        { }, "XF86AudioLowerVolume", -> APW\down!,
        {description: "Decrease volume", group: "multimedia"}),
    awful.key(
        { }, "XF86AudioMute", -> APW\toggle_mute!,
        {description: "Mute", group: "multimedia"})

    awful.key(
        { }, "XF86AudioPrev", -> MPC\prev!,
        {description: "Increase volume", group: "multimedia"}),
    awful.key(
        { }, "XF86AudioPlay", -> MPC\toggle_play!,
        {description: "Decrease volume", group: "multimedia"}),
    awful.key(
        { }, "XF86AudioNext", -> MPC\next!,
        {description: "Mute", group: "multimedia"})
)

clientkeys = gears.table.join(
    awful.key(
        { modkey, "Shift" }, "f", =>
            @fullscreen = not @fullscreen
            @raise!,
        {description: "toggle fullscreen", group: "client"}),
    awful.key(
        { modkey, }, "q", => @kill!,
        {description: "close", group: "client"}),
    awful.key(
        { modkey, "Control" }, "space", awful.client.floating.toggle,
        {description: "toggle floating", group: "client"}),
    awful.key(
        { modkey, "Control" }, "Return", => @swap(awful.client.getmaster!),
        {description: "move to master", group: "client"}),
    awful.key(
        { modkey, "Shift"   }, "j", => @move_to_screen(@screen.index - 1),
        {description: "move client to previous screen", group: "screen"}),
    awful.key(
        { modkey, "Shift"   }, "k", => @move_to_screen(@screen.index + 1),
        {description: "move client to next screen", group: "screen"}),
    awful.key(
        { modkey,           }, "t", => @ontop = not @ontop,
        {description: "toggle keep on top", group: "client"}),
    awful.key(
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
        { modkey,           }, "n", => @minimized = true,
        {description: "minimize", group: "client"}),
    awful.key(
        { modkey,           }, "m", =>
            @maximized = not @maximized
            @raise!,
        {description: "(un)maximize", group: "client"}),
    awful.key(
        { modkey, "Control" }, "m", =>
            @maximized_vertical = not @maximized_vertical
            @raise!,
        {description: "(un)maximize vertically", group: "client"}),
    awful.key(
        { modkey, "Shift"   }, "m", =>
            @maximized_horizontal = not @maximized_horizontal
            @raise!,
        {description: "(un)maximize horizontally", group: "client"}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
    keys = gears.table.join(keys,
        awful.key({ modkey }, "#" .. i + 9, ->
        -- View tag only
                tag = awful.screen.focused!.tags[i]
                tag\view_only! if tag,
            {description: "view tag #"..i, group: "tag"}),
        awful.key({ modkey, "Control" }, "#" .. i + 9, ->
        -- Toggle tag display.
                tag = awful.screen.focused!.tags[i]
                awful.tag.viewtoggle(tag) if tag,
            {description: "toggle tag #" .. i, group: "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, ->
        -- Move client to tag.
                if client.focus
                    tag = client.focus.screen.tags[i]
                    client.focus\move_to_tag(tag) if tag,
            {description: "move focused client to tag #"..i, group: "tag"}),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, ->
        -- Toggle tag on focused client.
                if client.focus
                    tag = client.focus.screen.tags[i]
                    client.focus\toggle_tag(tag) if tag,
            {description: "toggle focused client on tag #" .. i, group: "tag"}))

move_clients_to_screen = (tag, dst) -> tag\swap(dst.tags[tag.index])

taglist_buttons = gears.table.join(
    awful.button({ }, 1, => @view_only!),
    awful.button({ }, 2, => client.focus\move_to_tag @ if client.focus),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, => client.focus\toggle_tag @ if client.focus),
    awful.button({ }, 4, => awful.tag.viewprev @screen),
    awful.button({ }, 5, => awful.tag.viewnext @screen))

tasklist_buttons = gears.table.join(
    awful.button({ }, 1, => @emit_signal("request::activate", "tasklist", {raise: true})),
    awful.button({ }, 2, => @kill!),
    awful.button({ }, 3, => @minimized = not @minimized),
    awful.button({ }, 4, -> awful.client.focus.byidx -1),
    awful.button({ }, 5, -> awful.client.focus.byidx 1),
    awful.button({ }, 8, -> awful.client.swap.byidx -1),
    awful.button({ }, 9, -> awful.client.swap.byidx 1))

-- buttons for the titlebar
window_title_buttons = (c) -> gears.table.join(
    awful.button({ }, 1, ->
        c\emit_signal("request::activate", "titlebar", {raise: true})
        awful.mouse.client.move(c)
    ),
    awful.button({ }, 2, -> c.minimized = true),
    awful.button({ }, 3, ->
        c\emit_signal("request::activate", "titlebar", {raise: true})
        awful.mouse.client.resize(c)
    ),
    awful.button({ }, 8, -> c\move_to_screen(c.screen.index - 1)),
    awful.button({ }, 9, -> c\move_to_screen(c.screen.index - 1)))

clientbuttons = gears.table.join(
    awful.button({ }, 1, => @emit_signal("request::activate", "mouse_click", {raise: true})),
    awful.button({ modkey }, 1, =>
        @emit_signal("request::activate", "mouse_click", {raise: true})
        awful.mouse.client.move(@)),
    awful.button({ modkey }, 2, =>
        -- @emit_signal("request::activate", "mouse_click", {raise: true})
        @minimized = true
        awful.mouse.client.move(@)),
    awful.button({ modkey }, 3, =>
        @emit_signal("request::activate", "mouse_click", {raise: true})
        awful.mouse.client.resize(@)))

layout_buttons = gears.table.join(
    awful.button({ }, 1, -> awful.layout.inc  1),
    awful.button({ }, 3, -> awful.layout.inc -1))

{
    :keys
    :clientkeys
    :taglist_buttons
    :tasklist_buttons
    :clientbuttons
    :window_title_buttons
    :layout_buttons
}
