class Pulseaudio
    new: =>
        @volume = 0     -- volume of default sink
        @mute = false   -- state of the mute flag of the default sink
        @default_sink = ""

        -- retrieve current state from pulseaudio
        @update_state

    update_state: =>
        -- find default sink
        @default_sink = string.match(@run("pactl get-default-sink"), "[^\n]+")

        if @default_sink == nil then
            @default_sink = ""
            return false

        -- retrieve volume of default sink
        out = @run("pactl get-sink-volume " .. @default_sink)
        @volume = tonumber(string.match(out, "front%-left: (%d+)")) / 0x10000

        -- retrieve mute state of default sink
        out = @run("pactl get-sink-mute " .. @default_sink)
        @mute = string.match(out, "Mute: (%a+)") == "yes"

    -- Run process and wait for it to end
    run: (command) =>
        p = io.popen(command)
        out = p\read("*a")
        p\close!
        return out

    -- Sets the volume of the default sink to vol from 0 to 1.
    set_volume: (vol) =>
        if vol > 1 then
            vol = 1

        if vol < 0 then
            vol = 0

        vol = vol * 0x10000
        -- set…
        @run("pactl set-sink-volume " .. @default_sink .. " " .. string.format("0x%x", math.floor(vol)))

        -- …and update values
        @update_state!


    -- Toggles the mute flag of the default default_sink.
    toggle_mute: =>
        if @mute then
            @run("pactl set-sink-mute " .. @default_sink .. " 0")
        else
            @run("pactl set-sink-mute " .. @default_sink .. " 1")

        -- …and updates values.
        @update_state!

Pulseaudio
