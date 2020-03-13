lgi = require "lgi"
GLib = lgi.GLib
Gio = lgi.Gio

parse_password = (host) ->
	-- This function is based on mpd_parse_host_password() from libmpdclient
	position = string.find(host, "@")
    return host if not position
	return string.sub(host, position + 1), string.sub(host, 1, position - 1)

class Mpc
    new: (host, port, password, error_handler, ...) =>
        host = host or os.getenv("MPD_HOST") or "localhost"
        port = port or os.getenv("MPD_PORT") or 6600
        host, password = parse_password(host) if not password
        with @
            ._host = host
            ._port = port
            ._password = password
            ._error_handler = error_handler or ->
            ._connected = false
            ._try_reconnect = false
            ._idle_commands = { ... }
        @_connect!

    _error: (err) =>
        @_connected = false
        @_error_handler(err)
        @_try_reconnect = not @_try_reconnect
        if @_try_reconnect
            @_connect!

    _connect: =>
        return if @_connected
        -- Reset all of our state
        @_reply_handlers = {}
        @_ping_reply = {}
        @_idle_commands_ping = false
        @_idle = false
        @_connected = true

        -- Set up a new connection
        local address
        if string.sub(@_host, 1, 1) == "/"
            -- It's a unix socket
            address = Gio.UnixSocketAddress.new(@_host)
        else
            -- Do a TCP connection
            address = Gio.NetworkAddress.new(@_host, @_port)
        client = Gio.SocketClient!
        conn, err = client\connect(address)

        if not conn
            @_error(err)
            return false

        input, output = conn\get_input_stream(), conn\get_output_stream!
        @_conn, @_output, @_input = conn, output, Gio.DataInputStream.new(input)

        -- Read the welcome message
        @_input\read_line!

        if @_password and @_password ~= "" then
            @_send("password " .. @_password)

        -- Set up the reading loop. This will asynchronously read lines by
        -- calling it@
        do_read = ->
            @_input\read_line_async(GLib.PRIORITY_DEFAULT, nil, (obj, res) ->
                line, err = obj\read_line_finish(res)
                -- Ugly API. On success we get string, length-of-string
                -- and on error we get nil, error. Other versions of lgi
                -- behave differently.
                if line == nil or tostring(line) == ""
                    err = "Connection closed"
                
                if type(err) ~= "number"
                    @_output, @_input = nil, nil
                    @_error(err)
                else
                    do_read!
                    line = tostring(line)
                    if line == "OK" or line\match("^ACK ")
                        success = line == "OK"
                        arg = if success then @_ping_reply else { line }
                        handler = @_reply_handlers[1]
                        table.remove(@_reply_handlers, 1)
                        @_ping_reply = {}
                        handler(success, arg)
                    else
                        _, _, key, value = string.find(line, "([^:]+):%s(.+)")
                        @_ping_reply[string.lower(key)] = value if key
            )
        do_read!

        -- To synchronize the state on startup, send the idle commands now. As a
        -- side effect, this will enable idle state.
        @_send_idle_commands(true)

        return self

    _send_idle_commands: (skip_stop_idle) =>
        -- We use a ping to unset this to make sure we never get into a busy
        -- loop sing idle / unidle commands. Next call to
        -- _send_idle_commands() might be ignored!
        return if @_idle_commands_ping

        if not skip_stop_idle
            @_stop_idle!

        @_idle_commands_ping = true
        for i = 1, #@_idle_commands, 2 do
            @_send(@_idle_commands[i], @_idle_commands[i+1])
        
        @_send("ping", -> @_idle_commands_ping = false)
        @_start_idle!

    _start_idle: =>
        error("Still idle?!") if @_idle
        -- idle mode was disabled by mpd
        @_send("idle", (success, reply) -> @_send_idle_commands! if reply.changed)
        @_idle = true

    _stop_idle: =>
        error("Not idle?!") if not @_idle
        @_output\write("noidle\n")
        @_idle = false
    
    _send: (command, callback) =>
        error("Still idle in send()?!") if @_idle
        @_output\write(command .. "\n")
        table.insert(@_reply_handlers, callback or ->)
    
    send: (...) =>
        @_connect!
        return if not @_connected
        args = { ... }
        error("Something is messed up, we should be idle here...") if not @_idle
        @_stop_idle!
        for i = 1, #args, 2 do
            @_send(args[i], args[i+1])
        @_start_idle!
    
    toggle_play: => @send("status", (success, status) -> if status.state == "stop" then @send("play") else @send("pause"))

    next: => @send("next")

    prev: => @send("previous")
{
    :Mpc
}
