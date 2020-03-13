local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("util")
local modkey = "Mod4"
local xrandr = require("xrandr")
local term = "alacritty"
local new_term = konsole
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = term .. " -e " .. editor
local keys = gears.table.join(awful.key({
  modkey
}, "s", hotkeys_popup.show_help, {
  description = "show help",
  group = "awesome"
}), awful.key({
  modkey
}, "p", function()
  return xrandr.xrandr()
end, {
  description = "switch monitor modes",
  group = "awesome"
}), awful.key({
  modkey
}, "Left", awful.tag.viewprev, {
  description = "view previous",
  group = "tag"
}), awful.key({
  modkey
}, "Right", awful.tag.viewnext, {
  description = "view next",
  group = "tag"
}), awful.key({
  modkey
}, "Escape", awful.tag.history.restore, {
  description = "go back",
  group = "tag"
}), awful.key({
  modkey
}, "j", function()
  return awful.client.focus.byidx(-1)
end, {
  description = "focus next by index",
  group = "client"
}), awful.key({
  modkey
}, "k", function()
  return awful.client.focus.byidx(1)
end, {
  description = "focus previous by index",
  group = "client"
}), awful.key({
  modkey,
  "Shift"
}, "j", function()
  return awful.client.swap.byidx(-1)
end, {
  description = "swap with next client by index",
  group = "client"
}), awful.key({
  modkey,
  "Shift"
}, "k", function()
  return awful.client.swap.byidx(1)
end, {
  description = "swap with previous client by index",
  group = "client"
}), awful.key({
  modkey,
  "Control"
}, "j", function()
  return awful.screen.focus_relative(-1)
end, {
  description = "focus the next screen",
  group = "screen"
}), awful.key({
  modkey,
  "Control"
}, "k", function()
  return awful.screen.focus_relative(1)
end, {
  description = "focus the previous screen",
  group = "screen"
}), awful.key({
  modkey
}, "u", awful.client.urgent.jumpto, {
  description = "jump to urgent client",
  group = "client"
}), awful.key({
  modkey
}, "Return", function()
  return awful.spawn(new_term)
end, {
  description = "open a terminal",
  group = "launcher"
}), awful.key({
  modkey,
  "Shift"
}, "r", awesome.restart, {
  description = "reload awesome",
  group = "awesome"
}), awful.key({
  modkey,
  "Shift"
}, "q", awesome.quit, {
  description = "quit awesome",
  group = "awesome"
}), awful.key({
  modkey
}, "l", function()
  return awful.tag.incmwfact(0.05)
end, {
  description = "increase master width factor",
  group = "layout"
}), awful.key({
  modkey
}, "h", function()
  return awful.tag.incmwfact(-0.05)
end, {
  description = "decrease master width factor",
  group = "layout"
}), awful.key({
  modkey,
  "Shift"
}, "h", function()
  return awful.tag.incnmaster(1, nil, true)
end, {
  description = "increase the number of master clients",
  group = "layout"
}), awful.key({
  modkey,
  "Shift"
}, "l", function()
  return awful.tag.incnmaster(-1, nil, true)
end, {
  description = "decrease the number of master clients",
  group = "layout"
}), awful.key({
  modkey,
  "Control"
}, "h", function()
  return awful.tag.incncol(1, nil, true)
end, {
  description = "increase the number of columns",
  group = "layout"
}), awful.key({
  modkey,
  "Control"
}, "l", function()
  return awful.tag.incncol(-1, nil, true)
end, {
  description = "decrease the number of columns",
  group = "layout"
}), awful.key({
  modkey
}, "space", function()
  return awful.layout.inc(1)
end, {
  description = "select next",
  group = "layout"
}), awful.key({
  modkey,
  "Shift"
}, "space", function()
  return awful.layout.inc(-1)
end, {
  description = "select previous",
  group = "layout"
}), awful.key({
  modkey
}, "d", function()
  return os.execute("rofi -show drun")
end, {
  description = "rofi apps",
  group = "launcher"
}), awful.key({
  modkey
}, "w", function()
  return os.execute("rofi -show window")
end, {
  description = "rofi windows",
  group = "launcher"
}), awful.key({
  modkey,
  "Shift"
}, "d", function()
  return os.execute("rofi -show run")
end, {
  description = "rofi commands",
  group = "launcher"
}), awful.key({ }, "Print", function()
  return os.execute(full_path("screenshot", {
    description = "Take screenshot of the whole screen",
    group = "multimedia"
  }))
end), awful.key({
  modkey
}, "Print", function()
  return os.execute(full_path("screenshot") .. " -s", {
    description = "Take screenshot with interactive selection",
    group = "multimedia"
  })
end), awful.key({
  modkey,
  "Shift"
}, "Print", function()
  return os.execute(full_path("screenshot") .. " -st 9999999", {
    description = "Take screenshot with interactive selection, auto snap",
    group = "multimedia"
  })
end), awful.key({ }, "XF86MonBrightnessUp", function()
  return os.execute("xbacklight -inc 5", {
    description = "Increase brightness",
    group = "multimedia"
  })
end), awful.key({ }, "XF86MonBrightnessDown", function()
  return os.execute("xbacklight -dec 5", {
    description = "Decrease brightness",
    group = "multimedia"
  })
end), awful.key({ }, "XF86AudioRaiseVolume", function()
  return os.execute("xbacklight -dec 5", {
    description = "Increase volume",
    group = "multimedia"
  })
end), awful.key({ }, "XF86AudioLowerVolume", function()
  return os.execute("xbacklight -dec 5", {
    description = "Decrease volume",
    group = "multimedia"
  })
end), awful.key({ }, "XF86AudioMute", function()
  return os.execute("xbacklight -dec 5", {
    description = "Mute",
    group = "multimedia"
  })
end))
local clientkeys = gears.table.join(awful.key({
  modkey
}, "f", function(self)
  self.fullscreen = not self.fullscreen
  return self:raise()
end, {
  description = "toggle fullscreen",
  group = "client"
}), awful.key({
  modkey
}, "q", function(self)
  return self:kill()
end, {
  description = "close",
  group = "client"
}), awful.key({
  modkey,
  "Control"
}, "space", awful.client.floating.toggle, {
  description = "toggle floating",
  group = "client"
}), awful.key({
  modkey,
  "Control"
}, "Return", function(self)
  return self:swap(awful.client.getmaster())
end, {
  description = "move to master",
  group = "client"
}), awful.key({
  modkey
}, "o", function(self)
  return self:move_to_screen()
end, {
  description = "move to screen",
  group = "client"
}), awful.key({
  modkey
}, "t", function(self)
  self.ontop = not self.ontop
end, {
  description = "toggle keep on top",
  group = "client"
}), awful.key({
  modkey
}, "n", function(self)
  self.minimized = true
end, {
  description = "minimize",
  group = "client"
}), awful.key({
  modkey
}, "m", function(self)
  self.maximized = not self.maximized
  return self:raise()
end, {
  description = "(un)maximize",
  group = "client"
}), awful.key({
  modkey,
  "Control"
}, "m", function(self)
  self.maximized_vertical = not self.maximized_vertical
  return self:raise()
end, {
  description = "(un)maximize vertically",
  group = "client"
}), awful.key({
  modkey,
  "Shift"
}, "m", function(self)
  self.maximized_horizontal = not self.maximized_horizontal
  return self:raise()
end, {
  description = "(un)maximize horizontally",
  group = "client"
}))
for i = 1, 8 do
  keys = gears.table.join(keys, awful.key({
    modkey
  }, "#" .. i + 9, function()
    local tag = awful.screen.focused().tags[i]
    if tag then
      return tag:view_only()
    end
  end, {
    description = "view tag #" .. i,
    group = "tag"
  }), awful.key({
    modkey,
    "Control"
  }, "#" .. i + 9, function()
    local tag = awful.screen.focused().tags[i]
    if tag then
      return awful.tag.viewtoggle(tag)
    end
  end, {
    description = "toggle tag #" .. i,
    group = "tag"
  }), awful.key({
    modkey,
    "Shift"
  }, "#" .. i + 9, function()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        return client.focus:move_to_tag(tag)
      end
    end
  end, {
    description = "move focused client to tag #" .. i,
    group = "tag"
  }), awful.key({
    modkey,
    "Control",
    "Shift"
  }, "#" .. i + 9, function()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        return client.focus:toggle_tag(tag)
      end
    end
  end, {
    description = "toggle focused client on tag #" .. i,
    group = "tag"
  }))
end
local taglist_buttons = gears.table.join(awful.button({ }, 1, function(self)
  return self:view_only()
end), awful.button({
  modkey
}, 1, function(self)
  if client.focus then
    return client.focus:move_to_tag(self)
  end
end), awful.button({ }, 3, awful.tag.viewtoggle), awful.button({
  modkey
}, 3, function(self)
  if client.focus then
    return client.focus:toggle_tag(self)
  end
end), awful.button({ }, 4, function(self)
  return awful.tag.viewnext(self.screen)
end), awful.button({ }, 5, function(self)
  return awful.tag.viewprev(self.screen)
end))
local tasklist_buttons = gears.table.join(awful.button({ }, 1, function(self)
  if self == client.focus then
    self.minimized = true
  else
    return self:emit_signal("request::activate", "tasklist", {
      raise = true
    })
  end
end), awful.button({ }, 2, function(self)
  return self:kill()
end), awful.button({ }, 4, function()
  return awful.client.focus.byidx(-1)
end), awful.button({ }, 5, function()
  return awful.client.focus.byidx(1)
end))
local clientbuttons = gears.table.join(awful.button({ }, 1, function(self)
  return self:emit_signal("request::activate", "mouse_click", {
    raise = true
  })
end), awful.button({
  modkey
}, 1, function(self)
  self:emit_signal("request::activate", "mouse_click", {
    raise = true
  })
  return awful.mouse.client.move(self)
end), awful.button({
  modkey
}, 3, function(self)
  self:emit_signal("request::activate", "mouse_click", {
    raise = true
  })
  return awful.mouse.client.resize(self)
end))
return {
  keys = keys,
  clientkeys = clientkeys,
  taglist_buttons = taglist_buttons,
  tasklist_buttons = tasklist_buttons,
  clientbuttons = clientbuttons
}
