export full_path = => os.getenv("HOME") .. "/.config/awesome/" .. @
export markup = (t) ->
    buf = "<span "
    for k, v in pairs(t)
        if k == "fg"
            k = "foreground"
        else if k == "bg"
            k = "background"
        buf ..= "#{k}=\"#{v}\" " if type(k) != "number"
    buf ..= ">#{t[1]}</span>"
    buf
