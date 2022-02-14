require "util"
awful = require "awful"
spawn_with_shell = awful.util.spawn_with_shell or awful.spawn.with_shell
wibox = require "wibox"
beautiful = require "beautiful"
Pulseaudio = require "apw.pulseaudio"
math = require "math"

-- Configuration variables
width         = 40        -- width in pixels of progressbar
margin_right  = 0         -- right margin in pixels of progressbar
margin_left   = 0         -- left margin in pixels of progressbar
margin_top    = 0         -- top margin in pixels of progressbar
margin_bottom = 0         -- bottom margin in pixels of progressbar
step          = 1      -- stepsize for volume change (ranges from 0 to 1)
mixer         = 'pavucontrol' -- mixer command
text_color    = beautiful.apw_fg_normal
bg_color      = beautiful.apw_bg_normal
bg_color_mute = beautiful.apw_bg_mute

-- End of configuration

p = Pulseaudio!

widget = wibox.widget.textbox!

_update = ->
    bg = p.mute and bg_color_mute or bg_color
    widget\set_markup(markup {
        fg: text_color
        bg: bg
        " " .. math.ceil(p.volume*100).."% "
    })

widget.set_mixer = (command) ->
	mixer = command

widget.up = ->
	p\step_volume(step)
	_update!

widget.down = ->
	p\step_volume(-step)
	_update!

widget.toggle_mute = ->
	p\toggle_mute!
	_update!

widget.update = ->
    p\update_state!
    _update!

widget.launch_mixer = ->
	spawn_with_shell(mixer)

-- register mouse button actions
widget\buttons(awful.util.table.join(
		awful.button({ }, 1, widget.toggle_mute),
		awful.button({ }, 3, widget.launch_mixer),
		awful.button({ }, 4, widget.up),
		awful.button({ }, 5, widget.down)))

-- initialize
widget.update!

widget
