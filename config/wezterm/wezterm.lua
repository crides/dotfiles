local wezterm = require 'wezterm'
local act = wezterm.action

local gruvbox = {
    red = "#cc241d",
    green = "#98971a",
    yellow = "#d79921",
    blue = "#458588",
    purple = "#b16286",
    aqua = "#689d9a",
    orange = "#d65d0e",
    light_red = "#fb4934",
    light_green = "#b8bb26",
    light_yellow = "#fabd2f",
    light_blue = "#83a598",
    light_purple = "#d3869b",
    light_aqua = "#8ec07c",
    light_orange = "#fe8019",
}

local gray = {
    "#1d2021",
    "#282828",
    "#3c3836",
    "#504945",
    "#665c54",
    "#7c6f64",
    "#928374",
    "#a89984",
    "#bdae93",
    "#d5c4a1",
    "#ebdbb2",
    "#fbf1c7",
}

function table.append(a)
    local t = {}
    for n = 1,#a do
        for _,v in ipairs(a[n]) do
            t[#t+1] = v
        end
    end
    return t
end

local function pre_streak_keys(name, streak_keys)
    local res = {}
    for _, bind in ipairs(streak_keys) do
        table.insert(res, {
            key = bind.key,
            mods = bind.mods or 'NONE',
            action = act.Multiple {
                act.ActivateKeyTable { name = name, timeout_milliseconds = 500, one_shot = false, replace_current = true },
                bind.action,
            },
        })
    end
    return res
end

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane in that tab
    return tab_info.active_pane.title
end

local switch_streak = {
    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
}

local resize_streak = {
    { mods = 'CTRL', key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 5 } },
    { mods = 'CTRL', key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 5 } },
    { mods = 'CTRL', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 5 } },
    { mods = 'CTRL', key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 5 } },
}

local move_tab_streak = {
    { mods = 'SHIFT', key = 'LeftArrow', action = act.MoveTabRelative(-1) },
    { mods = 'SHIFT', key = 'RightArrow', action = act.MoveTabRelative(1) },
}

local font = {
    font = wezterm.font "Iosevka Term",
    font_size = 12,
}

local tab_select = {}
for i=1,9 do
    table.insert(tab_select, { key = tostring(i), action = act.ActivateTab(i - 1) })
end
table.insert(tab_select, { key = '0', action = act.ActivateTab(9) })
for i=1,12 do
    table.insert(tab_select, { key = string.format("F%d", i), action = act.ActivateTab(i + 9) })
end

wezterm.on('update-status', function(win, pane)
    win:set_left_status(wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Background = { Color = gruvbox.light_blue } },
        { Foreground = { Color = gray[5] } },
        { Text = string.format(' %s ', win:active_workspace()) },
        { Foreground = { Color = gruvbox.light_blue } },
        { Background = { Color = gray[1] } },
        { Text = '' },
    })
    local right_status = {
        { Background = { Color = gray[1] } },
        { Foreground = { Color = gray[5] } },
        { Text = '' },
        { Foreground = { Color = gray[#gray - 1] } },
        { Background = { Color = gray[5] } },
        { Text = wezterm.strftime(' %Y-%m-%d  %H:%M ') },
        { Foreground = { Color = gruvbox.light_aqua } },
        { Background = { Color = gray[5] } },
        { Text = '' },
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = gray[5] } },
        { Background = { Color = gruvbox.light_aqua } },
        { Text = string.format(' %s ', wezterm.hostname()) },
    }
    local key_table = win:active_key_table()
    if key_table then
        if key_table == 'prefix' then
            key_table = '`'
        end
        right_status = {
            { Foreground = { Color = gruvbox.light_aqua } },
            { Text = '' },
            { Foreground = { Color = gray[1] } },
            { Background = { Color = gruvbox.light_aqua } },
            { Text = string.format(' %s ', key_table) },
            table.unpack(right_status)
        }
    end
    win:set_right_status(wezterm.format(right_status))
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local function format_tab(ind, title, fg, bg)
        return {
            { Foreground = { Color = gray[1] } },
            { Background = { Color = fg } },
            { Text = '' },
            { Foreground = { Color = bg } },
            { Text = string.format(' %d  %s ', ind + 1, title) },
            { Foreground = { Color = fg } },
            { Background = { Color = gray[1] } },
            { Text = '' },
        }
    end
    local title = tab_title(tab)
    if tab.is_active then
        return format_tab(tab.tab_index, title, gruvbox.light_aqua, gray[1])
    else
        return format_tab(tab.tab_index, title, gray[5], gray[#gray - 1])
    end
end)

return {
    adjust_window_size_when_changing_font_size = false,
    audible_bell = "Disabled",
    check_for_updates = true,
    colors = {
        quick_select_label_bg = { Color = gruvbox.light_orange },
        quick_select_label_fg = { Color = gray[1] },
        quick_select_match_bg = { Color = gruvbox.light_purple },
        quick_select_match_fg = { Color = gray[1] },
        scrollbar_thumb = gray[7],
        tab_bar = { background = gray[1] },
    },
    color_scheme = "Gruvbox dark, hard (base16)",
    disable_default_key_bindings = true,
    enable_scroll_bar = true,
    font = font.font,
    font_size = font.font_size,
    inactive_pane_hsb = { saturation = 0.95, brightness = 0.75 },
    quick_select_alphabet = 'fdsarevcwqxznklbuim,op.j',
    scrollback_lines = 1048576,
    show_new_tab_button_in_tab_bar = false,
    show_update_window = true,
    tab_max_width = 100,
    use_fancy_tab_bar = false,
    visual_bell = {
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 150,
    },
    window_frame = font,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

    keys = {
        {
            key = '`',
            action = act.ActivateKeyTable {
                name = 'prefix',
                replace_current = true,
                -- prevent_fallback = true,
            }
        },
        { mods = 'CTRL', key = '=', action = act.IncreaseFontSize },
        { mods = 'CTRL', key = '-', action = act.DecreaseFontSize },
        { mods = 'CTRL|SHIFT', key = 'P', action = act.ActivateCommandPalette },
        { mods = 'CTRL|SHIFT', key = 'D', action = act.ShowDebugOverlay },
        {
            mods = 'SHIFT|CTRL',
            key = 'u',
            action = wezterm.action.CharSelect { copy_on_select = false },
        },
    },
    key_tables = {
        prefix = {
            { key = '`', action = act.SendString '`' },
            { key = '[', action = act.ActivateCopyMode },
            { key = ']', action = act.PasteFrom 'Clipboard' },

            { key = 'c', action = act.SpawnTab 'DefaultDomain' },
            { mods = 'SHIFT', key = 'C', action = act.SpawnTab 'CurrentPaneDomain' },
            { key = 'p', action = act.ActivateTabRelative(-1) },
            { key = 'n', action = act.ActivateTabRelative(1) },
            { key = '\\', action = act.ActivateLastTab },
            { key = ';', action = act.PaneSelect },
            { mods = 'SHIFT', key = ':', action = act.PaneSelect { mode = 'SwapWithActive' } }, -- TODO KeepFocus

            { mods = 'SHIFT', key = '%', action = act.SplitPane { direction = "Right" } },
            { mods = 'SHIFT', key = '"', action = act.SplitPane { direction = "Down" } },
            { key = 'h', action = act.ActivatePaneDirection 'Left' },
            { key = 'j', action = act.ActivatePaneDirection 'Down' },
            { key = 'k', action = act.ActivatePaneDirection 'Up' },
            { key = 'l', action = act.ActivatePaneDirection 'Right' },
            { mods = 'SHIFT', key = 'F', action = act.QuickSelect },
            { key = 'z', action = act.TogglePaneZoomState },
            { key = 'x', action = act.CloseCurrentPane { confirm = true } },
            -- TODO { mods = 'SHIFT', key = '!', action = act.PaneSelect { mode = 'MoveToNewTab' } },
            { mods = 'SHIFT', key = '{', action = act.RotatePanes 'CounterClockwise' },
            { mods = 'SHIFT', key = '}', action = act.RotatePanes 'Clockwise' },

            { mods = 'SHIFT', key = '(', action = act.SwitchWorkspaceRelative(-1) },
            { mods = 'SHIFT', key = ')', action = act.SwitchWorkspaceRelative(1) },

            { mods = 'CTRL', key = 'l', action = act.ShowLauncher },

            {
                key = ',',
                action = act.PromptInputLine {
                    description = "(rename tab) ",
                    action = wezterm.action_callback(function(win, pane, line)
                        if line then
                            win:active_tab():set_title(line)
                        end
                    end),
                },
            },
            {
                mods = 'SHIFT',
                key = '$',
                action = act.PromptInputLine {
                    description = "(rename window) ",
                    action = wezterm.action_callback(function(win, pane, line)
                        if line then
                            win:mux_window():set_workspace(line)
                            -- win:perform_action(act.SwitchToWorkspace { name = line }, pane)
                        end
                    end),
                },
            },
            table.unpack(table.append {
                pre_streak_keys("switch_streak", switch_streak),
                pre_streak_keys("resize_streak", resize_streak),
                pre_streak_keys("move_tab_streak", move_tab_streak),
                tab_select,
            }),
        },
        copy_mode = {
            { key = 'Escape', action = act.CopyMode 'ClearSelectionMode' },
            { key = 'c', mods = 'CTRL', action = act.Multiple {
                act.CopyMode 'ClearSelectionMode',
                act.CopyMode 'Close',
            } },
            { key = 'q', action = act.Multiple {
                act.CopyMode 'ClearSelectionMode',
                act.CopyMode 'Close',
            } },
            { key = 'Space', action = act.CopyMode { SetSelectionMode =  'Cell' } },
            { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
            { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
            { key = '0', action = act.CopyMode 'MoveToStartOfLine' },

            { key = 'f', action = act.CopyMode { JumpForward = { prev_char = false } } },
            { key = 'F', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
            { key = 't', action = act.CopyMode { JumpForward = { prev_char = true } } },
            { key = 'T', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
            { key = ',', action = act.CopyMode 'JumpReverse' },
            { key = ';', action = act.CopyMode 'JumpAgain' },

            { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
            { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
            { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },

            { key = 'v', action = act.CopyMode { SetSelectionMode = 'Cell' } },
            { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },
            { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
            { key = 'V', mods = 'CTRL|SHIFT', action = act.CopyMode { SetSelectionMode = 'SemanticZone' } },
            { key = 'o', action = act.CopyMode 'MoveToSelectionOtherEnd' },
            { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
            { key = 'y', action = act.Multiple {
                act.CopyTo 'ClipboardAndPrimarySelection',
                act.CopyMode 'Close',
            } },
            { key = 'y', action = act.Multiple {
                act.CopyTo 'ClipboardAndPrimarySelection',
                act.CopyMode 'Close',
            } },

            { key = 'w', action = act.CopyMode 'MoveForwardWord' },
            { key = 'e', action = act.CopyMode 'MoveForwardWordEnd' },
            { key = 'b', action = act.CopyMode 'MoveBackwardWord' },
            { key = '(', mods = 'SHIFT', action = act.CopyMode { MoveBackwardZoneOfType = 'Prompt' } },
            { key = ')', mods = 'SHIFT', action = act.CopyMode { MoveForwardZoneOfType = 'Prompt' } },

            { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
            { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
            { key = 'u', mods = 'CTRL', action = act.CopyMode { MoveByPage = -0.5 } },
            { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = 0.5 } },
            { key = 'e', mods = 'CTRL', action = act.Multiple {
                act.CopyMode 'MoveToViewportBottom',
                act.CopyMode 'MoveDown',
            } },
            { key = 'y', mods = 'CTRL', action = act.Multiple {
                act.CopyMode 'MoveToViewportTop',
                act.CopyMode 'MoveUp',
            } },

            { key = 'h', action = act.CopyMode 'MoveLeft' },
            { key = 'j', action = act.CopyMode 'MoveDown' },
            { key = 'k', action = act.CopyMode 'MoveUp' },
            { key = 'l', action = act.CopyMode 'MoveRight' },
            { key = 'g', action = act.CopyMode 'MoveToScrollbackTop' },
            { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },

            { key = 'q', action = act.CopyMode 'Close' },
            { key = 'PageUp', action = act.CopyMode 'PageUp' },
            { key = 'PageDown', action = act.CopyMode 'PageDown' },
            { key = 'End', action = act.CopyMode 'MoveToEndOfLineContent' },
            { key = 'Home', action = act.CopyMode 'MoveToStartOfLine' },
            { key = 'LeftArrow', action = act.CopyMode 'MoveLeft' },
            { key = 'RightArrow', action = act.CopyMode 'MoveRight' },
            { key = 'UpArrow', action = act.CopyMode 'MoveUp' },
            { key = 'DownArrow', action = act.CopyMode 'MoveDown' },

            { key = '/', action = act.CopyMode 'EditPattern' },
            { key = '?', mods = 'SHIFT', action = act.CopyMode 'EditPattern' },
            { key = 'Enter', action = act.CopyMode 'AcceptPattern' },
            { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
            { key = 'n', action = act.CopyMode 'NextMatch' },
            { key = 'N', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
            { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatchPage' },
            { key = 'N', mods = 'CTRL|SHIFT', action = act.CopyMode 'PriorMatchPage' },
        },
        search_mode = {
            { key = 'Enter', mods = 'NONE', action = act.CopyMode 'AcceptPattern' },
            { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
            { key = 'n', action = act.CopyMode 'NextMatch' },
            { key = 'N', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
            { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatchPage' },
            { key = 'N', mods = 'CTRL|SHIFT', action = act.CopyMode 'PriorMatchPage' },
            { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
            { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
        },
        switch_streak = switch_streak,
        resize_streak = resize_streak,
        move_tab_streak = move_tab_streak,
    },
}
