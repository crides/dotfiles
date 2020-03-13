cmd = "pacmd"
default_sink = ""

class Pulseaudio
    new: =>
        @volume = 0     -- volume of default sink
        @mute = false   -- state of the mute flag of the default sink

        -- retrieve current state from pulseaudio
        @update_state

    update_state: =>
        f = io.popen(cmd .. " dump")

        -- if the cmd cannot be found
        if f == nil then
            return false

        out = f\read("*a")
        f\close!

        -- find default sink
        default_sink = string.match(out, "set%-default%-sink ([^\n]+)")

        if default_sink == nil then
            default_sink = ""
            return false

        -- retrieve volume of default sink
        for sink, value in string.gmatch(out, "set%-sink%-volume ([^%s]+) (0x%x+)") do
            if sink == default_sink then
                @volume = tonumber(value) / 0x10000

        -- retrieve mute state of default sink
        local m
        for sink, value in string.gmatch(out, "set%-sink%-mute ([^%s]+) (%a+)") do
            if sink == default_sink then
                m = value

        @mute = m == "yes"

    -- Run process and wait for it to end
    run: (command) =>
        p = io.popen(command)
        p\read("*a")
        p\close!

    -- Sets the volume of the default sink to vol from 0 to 1.
    set_volume: (vol) =>
        if vol > 1 then
            vol = 1

        if vol < 0 then
            vol = 0

        vol = vol * 0x10000
        -- set…
        @run(cmd .. " set-sink-volume " .. default_sink .. " " .. string.format("0x%x", math.floor(vol)))

        -- …and update values
        @update_state!


    -- Toggles the mute flag of the default default_sink.
    toggle_mute: =>
        if @mute then
            @run(cmd .. " set-sink-mute " .. default_sink .. " 0")
        else
            @run(cmd .. " set-sink-mute " .. default_sink .. " 1")

        -- …and updates values.
        @update_state!

Pulseaudio
