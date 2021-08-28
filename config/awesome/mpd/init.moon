require "moonscript"
mpc = require "mpd.mpc"
wibox = require "wibox"
awful = require "awful"
beautiful = require "beautiful"
naughty = require "naughty"
gears = require "gears"
require "util"
(require "fun")()

ICON_PATH = full_path "mpd/"

prev_btn = wibox.widget.textbox!
prev_btn\set_markup(markup {
    size: "x-large",
    fg: beautiful.white,
    " 玲 "
})
prev_btn\buttons(awful.button({}, 2, -> MPC\prev!))

next_btn = wibox.widget.textbox!
next_btn\set_markup(markup {
    size: "x-large",
    fg: beautiful.white,
    " 怜"
})
next_btn\buttons(awful.button({}, 2, -> MPC\next!))

textbox = wibox.widget {
    {
        {
            id: "bar",
            max_value: 1,
            value: 0.7,
            forced_width: 10,
            forced_height: 1,
            height: 1,
            color: beautiful.cyan,
            background_color: beautiful.black,
            widget: wibox.widget.progressbar,
        }
        id: "box",
        top: 5,
        bottom: 5,
        widget: wibox.container.margin,
    },
    {
        id: "text",
        text: "",
        widget: wibox.widget.textbox,
    },
    forced_height: 1,
    layout: wibox.layout.stack,
}
textbox.text\buttons(awful.button({}, 1, -> MPC\toggle_play!))

widget = wibox.widget {
    prev_btn,
    textbox,
    next_btn,
    layout: wibox.layout.fixed.horizontal,
}

state, title, artist, file, album, elapsed, duration = "stop", "", "", "", "", 0, 0

update_widget = ->
    fg = beautiful.cyan
    if state == "pause" then
        fg = beautiful.darkgray
    if state == "stop" then
        fg = beautiful.red
    text = title
    if not text
        text = "(Not Playing)"
    textbox.text\set_markup(markup {
        fg: beautiful.white,
        text,
    })
    textbox.box.bar\set_value(elapsed / duration)
    textbox.box.bar.color = fg

error_handler = (err) ->
    textbox.text\set_text("Error: " .. tostring(err))
    -- Try a reconnect soon-ish
    --timer.start_new(10, -> MPC\send("ping"))

export MPC = mpc.Mpc(nil, nil, nil, error_handler,
    "status", ((_, result) ->
        buf = ""
        for k, v in pairs(result) do
            buf = buf .. tostring(k) .. ": " .. tostring(v) .. "\n"
        elapsed = result.elapsed or 0
        state = result.state
        update_widget!),
    "currentsong", (_, result) ->
        { :title, :artist, :file, :album, :duration } = result
        duration = duration or 1
        update_widget!)

gears.timer {
    timeout: 3,
    call_now: true,
    autostart: true,
    callback: ->
        MPC\send("status", (_, result) ->
            elapsed = result.elapsed or 0
            state = result.state
            update_widget!)
}

with awful.tooltip
        objects: {textbox.text}
        timer_function: ->
            "<b>Artist:</b> #{artist}
<b>Album:</b> #{album}
<b>Title:</b> #{title}"
        delay_show: 3
    .mode = "outside"
    .preferred_alignments = {"middle"}

widget
