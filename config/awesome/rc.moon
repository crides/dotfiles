pcall require, "luarocks.loader"

gears = require "gears"
awful = require "awful"
require "awful.autofocus"
wibox = require "wibox"
beautiful = require "beautiful"
naughty = require "naughty"
require "awful.hotkeys_popup.keys"
gtable = require "gears.table"
require "util"
keys = require "keys"
lain = require "lain"

-- Init sub-widgets
beautiful.init require "theme"
export APW = require "apw/widget"

naughty.config.defaults.position = "bottom_middle"
naughty.config.presets.normal.fg = beautiful.black
naughty.config.presets.normal.bg = beautiful.white
naughty.config.presets.critical.fg = beautiful.black
naughty.config.presets.critical.bg = beautiful.red

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors
    naughty.notify
        preset: naughty.config.presets.critical
        title: "Oops, there were errors during startup!"
        text: awesome.startup_errors

-- Handle runtime errors after startup
do
    in_error = false
    awesome.connect_signal("debug::error", (err) ->
        -- Make sure we don't go into an endless error loop
        return if in_error
        in_error = true

        buf = ""
        for k, v in pairs(err)
            buf = buf .. tostring(k) .. ": " .. tostring(v) .. "\n"
        naughty.notify
            preset: naughty.config.presets.critical
            title: "Oops, an error happened!"
            text: buf
        in_error = false)
-- }}}

root.keys keys.keys
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating
    awful.layout.suit.fair
    awful.layout.suit.tile
    awful.layout.suit.tile.bottom
    awful.layout.suit.max      -- like tabbed layout
}
-- }}}

date_module = with wibox.widget.textclock!
    .format = markup { bg: beautiful.cyan, fg: beautiful.black, " %a %b %d " }

time_module = with wibox.widget.textclock!
    .format = markup { bg: beautiful.blue, fg: beautiful.black, " %H:%M " }

wifi_module = awful.widget.watch(
    'sh -c "nmcli c s --active | rg wifi | tail -n1 | rargs echo {1}"',
    5, (widget, output) ->
        output = output\gsub("\n", "")
        widget.markup = markup {
            bg: beautiful.yellow
            fg: beautiful.black
            " #{output} "
        })

mpd_module = require "mpd"

bat_module = lain.widget.bat {
    timeout: 15
    settings: ->
        perc = bat_now.perc
        bg = beautiful.red
        if perc > 75
            bg = beautiful.green
        else if perc > 30
            bg = beautiful.yellow
        widget\set_markup(
            markup {
                :bg
                fg: beautiful.black
                " " .. perc .. "% " .. bat_now.time .. " "
            })
}

set_wallpaper = =>
    -- Wallpaper
    if beautiful.wallpaper
        wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        wallpaper = wallpaper(@) if type(wallpaper) == "function"
        gears.wallpaper.maximized(wallpaper, @, true)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal "property::geometry", set_wallpaper

window_indicator = awful.popup
    widget: {
        widget: wibox.layout.fixed.horizontal
        opacity: 0
    }
    border_color: beautiful.green
    border_width: 5
    visible: false
    bg: '#00000000'
    ontop: true

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen =>
    -- Wallpaper
    set_wallpaper(@)

    -- Each screen has its own tag table.
    awful.tag { "1", "2", "3", "4", "5", "6", "7", "8" }, @, awful.layout.suit.max

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    @mylayoutbox = with awful.widget.layoutbox(@)
        \buttons(gears.table.join(
            awful.button({ }, 1, -> awful.layout.inc  1),
            awful.button({ }, 3, -> awful.layout.inc -1)))

    @mytaglist = awful.widget.taglist {
        screen: @,
        filter: awful.widget.taglist.filter.all,
        layout: wibox.layout.fixed.horizontal,
        widget_template: {
            {
                {
                    {
                        id: 'index_role',
                        widget: wibox.widget.textbox,
                    },
                    left: 5,
                    right: 5,
                    widget: wibox.container.margin
                },
                top: 4,
                widget: wibox.container.margin,
            },
            widget: wibox.container.background,
            create_callback: (c3, index, objects) =>
                @update_callback(c3, index, objects)
            update_callback: (c3, index, objects) =>
                cur_tag = awful.screen.focused!.tags[index]
                index_color, @bg = if cur_tag.selected
                    beautiful.taglist_fg_focus, beautiful.taglist_bg_focus
                else
                    beautiful.taglist_fg_normal, beautiful.taglist_bg_normal
                @widget.color = if #cur_tag\clients! ~= 0 then beautiful.magenta else beautiful.taglist_bg_normal
                @widget.color = beautiful.green if client.focus and gtable.hasitem(client.focus\tags!, cur_tag)
                @get_children_by_id('index_role')[1].markup = markup {
                    fg: index_color
                    index
                }
        },
        buttons: keys.taglist_buttons
    }

    -- Create a tasklist widget
    @mytasklist = awful.widget.tasklist {
        screen: self
        filter: awful.widget.tasklist.filter.currenttags
        buttons: keys.tasklist_buttons
        widget_template: {
            id: 'background_role',
            widget: wibox.container.background,
            {
                widget: wibox.container.margin,
                left: 5,
                right: 5,
                {
                    widget: wibox.layout.fixed.horizontal,
                    spacing: 3,
                    {
                        widget: wibox.widget.textbox,
                    },
                    {
                        id: 'icon',
                        widget: awful.widget.clienticon,
                    },
                    {
                        id: 'text_role',
                        widget: wibox.widget.textbox,
                    },
                },
            },
            create_callback: (c, index, objs) =>
                @get_children_by_id('icon')[1].client = c
                with awful.tooltip
                        objects: {@}
                        timer_function: ->
                            if c
                                with window_indicator
                                    .x = c.x
                                    .y = c.y
                                    .widget.forced_height = c.height - 10
                                    .widget.forced_width = c.width - 10
                                    .visible = true
                                c.name
                            else
                                ""
                        delay_show: 1
                    .mode = "outside"
                    .preferred_alignments = {"middle"}
                @update_callback(c, index, objs)
            update_callback: (c, index, objs) =>
                text_color = if client.focus == c
                    beautiful.tasklist_fg_focus
                else
                    beautiful.tasklist_fg_normal
                flag = ""
                flag ..= 'M' if c.maximized
                flag ..= 'F' if c.floating
                @widget.widget.children[1].markup = markup {
                    fg: text_color
                    flag
                }
        }
    }
    @mytasklist\connect_signal("mouse::leave", ->
        window_indicator.visible = false)

    -- Create the wibox
    with awful.wibar
            position: "top"
            screen: @
        \setup {
            layout: wibox.layout.align.horizontal
            {
                layout: wibox.layout.fixed.horizontal
                spacing: 10
                @mytaglist
            },
            @mytasklist, -- Middle widget
            { -- Right widgets
                layout: wibox.layout.fixed.horizontal
                spacing: 10
                -- awful.widget.keyboardlayout!
                mpd_module
                wibox.widget.systray!
                APW
                bat_module.widget
                wifi_module
                date_module
                time_module
                @mylayoutbox
            }
        }
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule: { },
      properties: {
          border_width: beautiful.border_width,
          border_color: beautiful.border_normal,
          focus: awful.client.focus.filter,
          raise: true,
          keys: keys.clientkeys,
          buttons: keys.clientbuttons,
          screen: awful.screen.preferred,
          placement: awful.placement.no_overlap+awful.placement.no_offscreen,
          titlebars_enabled: true,
          floating: false
      }
    },

    -- Floating clients.
    { rule_any: {
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        type: {
            "dialog",
        },
        name: {
            "Event Tester",  -- xev.
        },
        role: {
            "AlarmWindow",  -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties: { floating: true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any: {type: { "normal", "dialog" }
      }, properties: { titlebars_enabled: true }
    },

    {
        rule_any: {
            name: {
                "SimpleScreenRecorder",
            },
        },
        properties: {
            floating: true,
        },
    },

    {
        rule_any: {
            name: {
                "dragon",
            },
        },
        properties: {
            floating: true,
            sticky: true,
            ontop: true,
        },
    },

    {
        rule_any: {
            name: {
                "Plover: Suggestion",
            },
        },
        properties: {
            focusable: false,
        },
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", (c) ->
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", (c) ->
    -- buttons for the titlebar
    buttons = gears.table.join(
        awful.button({ }, 1, ->
            c\emit_signal("request::activate", "titlebar", {raise: true})
            awful.mouse.client.move(c)
        ),
        awful.button({ }, 2, ->
            c.minimized = true
        ),
        awful.button({ }, 3, ->
            c\emit_signal("request::activate", "titlebar", {raise: true})
            awful.mouse.client.resize(c)
        )
    )

    awful.titlebar(c)\setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons: buttons,
            layout: wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align: "center",
                widget: awful.titlebar.widget.titlewidget(c)
            },
            buttons: buttons,
            layout: wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout: wibox.layout.fixed.horizontal
        },
        layout: wibox.layout.align.horizontal
    }
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", (c) ->
    c\emit_signal("request::activate", "mouse_enter", {raise: false})
)

client.connect_signal("focus", (c) -> c.border_color = beautiful.border_focus)
client.connect_signal("unfocus", (c) -> c.border_color = beautiful.border_normal)
-- }}}

-- Autostart
awful.spawn.easy_async("xrdb " .. full_path("gruvbox-dark-hard.Xresources"))
awful.spawn.easy_async("picom -b")
awful.spawn.easy_async("xiput disable $(xinput list | rg 'Touchpad\\s*id=(\\d+)' -or '$1')")
