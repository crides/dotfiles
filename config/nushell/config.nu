def path_exists [p: string] {
    try {
        $p | path exists
    } catch {
        false
    }
}

def path_underline [color: string] {
    {|p| if (path_exists $p) {
            $color + "_underline"
        } else {
            $color
        }
    }
}

def is_alias [cmd: string] {
    ((which $cmd).type | get -i 0) == "alias"
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: false

    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }

    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    # datetime_format determines what a datetime rendered in the shell would look like.
    # Behavior without this configuration point will be to "humanize" the datetime display,
    # showing something like "a day ago."
    datetime_format: {
        # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
        # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }

    explore: {
        status_bar_background: {fg: "#1D1F21", bg: "#C4C9C6"},
        command_bar_text: {fg: "#C4C9C6"},
        highlight: {fg: "black", bg: "yellow"},
        status: {
            error: {fg: "white", bg: "red"},
            warn: {}
            info: {}
        },
        table: {
            split_line: {fg: "light_gray"},
            selected_cell: {bg: light_blue},
            selected_row: {},
            selected_column: {},
        },
    }

    history: {
        max_size: 100_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "sqlite" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: null # check 'carapace_completer' above as an example
        }
    }

    filesize: {
        metric: false
        format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
    }

    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }

    color_config: {
        separator: "light_gray"
        leading_trailing_space_bg: { attr: "n" }
        header: { fg: white attr: "b" }
        empty: "light_blue"
        bool: {|| if $in { "light_cyan" } else { "dark_gray" } }
        int: "light_purple"
        filesize: {||
            if $in == 0b {
                "light_gray"
            } else if $in < 1mb {
                "light_cyan"
            } else {{ fg: "light_blue" }}
        }
        duration: "light_gray"
        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: light_red attr: "b" }
            } else if $in < 6hr {
                "light_red"
            } else if $in < 1day {
                "light_yellow"
            } else if $in < 3day {
                "light_green"
            } else if $in < 1wk {
                { fg: light_green attr: "b" }
            } else if $in < 6wk {
                "light_cyan"
            } else if $in < 52wk {
                "light_blue"
            } else { "dark_gray" }
        }
        range: "light_purple"
        float: "light_purple"
        string: "light_green"
        nothing: "dark_gray"
        binary: "light_purple"
        cellpath: "white"
        row_index: { fg: white attr: "b" }
        record: "white"
        list: "white"
        block: "white"
        hints: "dark_gray"
        search_result: { fg: black bg: light_cyan }

        shape_and: { fg: light_purple attr: "b" }
        shape_binary: { fg: light_purple attr: "b" }
        shape_block: { fg: light_blue attr: "b" }
        shape_bool: light_cyan
        shape_custom: { fg: "#d65d0e" }
        shape_datetime: { fg: light_cyan attr: "b" }
        shape_directory: (path_underline "light_yellow")
        shape_external: {|p| 
            if (is_alias $p) {
                "light_cyan"
            } else if (path_exists $p) {
                "light_green_underline"
            } else {
                "red"
            }
        }
        shape_external_resolved: (path_underline "light_green")
        shape_externalarg: (path_underline "white")
        shape_filepath: (path_underline "light_yellow")
        shape_flag: { fg: light_blue attr: "b" }
        shape_float: { fg: light_purple attr: "b" }
        shape_garbage: { fg: "white" bg: "light_red" attr: "b" }
        shape_globpattern: (path_underline "light_blue")
        shape_int: { fg: light_purple attr: "b" }
        shape_internalcall: {|p|
            if (is_alias $p) {
                "light_cyan"
            } else {
                { fg: light_cyan attr: "b" }
            }
        }
        shape_list: { fg: light_cyan attr: "b" }
        shape_literal: light_yellow
        shape_match_pattern: light_green
        shape_matching_brackets: { attr: "u" }
        shape_nothing: white
        # shape_operator: light_yellow
        shape_or: { fg: light_purple attr: "b" }
        shape_pipe: { fg: light_purple attr: "b" }
        shape_range: { fg: light_yellow attr: "b" }
        shape_record: { fg: light_cyan attr: "b" }
        shape_redirection: { fg: light_purple attr: "b" }
        shape_signature: { fg: light_green attr: "b" }
        shape_string: (path_underline "light_green")
        shape_string_interpolation: { fg: light_cyan attr: "b" }
        shape_table: { fg: light_blue attr: "b" }
        shape_variable: light_purple

        background: "black"
        foreground: "#fbf1c7"
        cursor: "#fbf1c7"
    }
    use_grid_icons: true
    footer_mode: "25" # always, never, number_of_rows, auto
    float_precision: 3 # the precision for displaying floats in tables
    buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: vi
    shell_integration: true # enables terminal shell integration. Off by default, as some terminals have issues with this.
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this
    highlight_resolved_externals: true

    hooks: {
        pre_prompt: [{ null }] # run before the prompt is shown
        pre_execution: [{ null }] # run before the repl input is run
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: { null } # return an error message when a command is not found
    }
    menus: [
        # Configuration for default nushell menus
        # Note the lack of souce parameter
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
            }
            style: {
                text: white
                selected_text: white_reverse
                description_text: yellow
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        # Example of extra menus created using a nushell source
        # Use the source field to create a list of records that populates
        # the menu
        {
            name: commands_menu
            only_buffer_difference: false
            marker: "# "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                $nu.scope.commands
                | where command =~ $buffer
                | each { |it| {value: $it.command description: $it.usage} }
            }
        }
        {
            name: vars_menu
            only_buffer_difference: true
            marker: "# "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                $nu.scope.vars
                | where name =~ $buffer
                | sort-by name
                | each { |it| {value: $it.name description: $it.type} }
            }
        }
        {
            name: commands_with_description
            only_buffer_difference: true
            marker: "# "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                $nu.scope.commands
                | where command =~ $buffer
                | each { |it| {value: $it.command description: $it.usage} }
            }
        }
    ]
    keybindings: [
        {
            name: B
            modifier: Shift
            keycode: Char_b
            mode: vi_normal
            event: { edit: MoveBigWordLeft }
        }
        {
            name: completion_previous
            modifier: shift
            keycode: backtab
            mode: [vi_normal vi_insert]
            event: { send: menuprevious }
        }
        {
            name: kill-word
            modifier: control keycode: char_w
            mode: vi_insert
            event: { edit: BackspaceWord }
        }
        {
            name: kill-line
            modifier: control keycode: char_u
            mode: vi_insert
            event: { edit: CutFromStart }
        }
        {
            name: exit
            modifier: control keycode: char_d
            mode: [vi_insert vi_normal]
            event: { send: CtrlD }
        }
        {
            name: fzf_insert_file
            modifier: control keycode: char_t
            mode: vi_insert
            event: { send: ExecuteHostCommand cmd: "commandline -i (^fd -HI -tf | ^fzf --height 40% --reverse --scheme=path --bind=ctrl-z:ignore -m)" }
        }
        {
            name: fzf_cd
            modifier: alt keycode: char_c
            mode: vi_insert
            event: { send: ExecuteHostCommand cmd: "cd (^fd -HI -td | ^fzf --height 40% --reverse --scheme=path --bind=ctrl-z:ignore)" }
        }
        {
            name: fzf_hist
            modifier: control keycode: char_r
            mode: [vi_insert vi_normal]
            event: { send: ExecuteHostCommand cmd: "commandline (history | get command | reverse | uniq | str replace '\n' '␤' | str trim | where $it != "" | to text | ^fzf --height 40% --reverse --scheme=history --bind=ctrl-z:ignore)" }
        }
    ]
}

alias e = nvim
alias v = neovide --multigrid
alias l = ^eza -F
alias la = ^eza -aF
alias ll = ^eza -alF --git
alias lt = ^eza -alFT --git
alias unlines = str join (char nl)
alias py = python3
alias ipy = ipython
alias md = mkdir
alias fm = nnn .

def ds [name: string] {
    let results = (fd $name -ie pdf $"($env.HOME)/Downloads/datasheet" | lines)
    let len = ($results | length)
    if $len == 0 {
        print "nothing"
    } else if $len == 1 {
        let file = ($results | first)
        print $file
        zathura --fork $file
    } else {
        print 'Too many results:'
        let ret = ($results | unlines | sk -m | lines)
        $ret | each {|f|
            print $f
            zathura --fork $f
        }
    }
    null
}

def hist [pat?: string, --cwd(-c)] {
    mut hist = history | rename time | into datetime time | update time { date to-timezone local }
    if $pat != null {
        $hist = ($hist | find $pat)
    }
    if $cwd {
        $hist = ($hist | where cwd == (pwd))
    }
    $hist
}

def notify [title: string, body: string] {
    ansi -o $"777;notify;($title);($body)"
}

def --env mc [dir: path] {
    mkdir $dir
    cd $dir
}

def tg [lang: string, pat: string] {
    let matches = (^tree-grepper -q $lang $pat  -f json | from json)
    for file in $matches {
        let matches = ($file.matches | each {|m| {start: $m.start.row end: (if $m.end.column == 1 { $m.end.row - 1 } else { $m.end.row })}})
        for match in $matches {
            ^bat -Plc -r $"($match.start):($match.end)" $file.file
        }
    }
}

def findc [name: string] {
    tg c ("(["
    + "(function_definition declarator: (function_declarator declarator: (identifier) @_d)) @f"
    + "(declaration declarator: (function_declarator declarator: (identifier) @_d)) @f"
    + "(declaration declarator: (init_declarator declarator: (identifier) @_d)) @f"
    + "(preproc_function_def name: (identifier) @_d) @f"
    + "(preproc_def name: (identifier) @_d) @f"
    + $"] \(#match? @_d \"($name)\"))")
}

source ($nu.default-config-dir | path join "zoxide-init.nu")
source ($nu.default-config-dir | path join "starship-init.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/cargo/cargo-completions.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/git/git-completions.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/feh.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/ffmpeg.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/fzf.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/jq.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/ln.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/mpv.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/objdump.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/objdump.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/rsync.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/tar.nu")
source ($nu.default-config-dir | path join "nu_scripts/custom-completions/auto-generate/completions/tokei.nu")
source ($nu.default-config-dir | path join "git-aliases.nu")
