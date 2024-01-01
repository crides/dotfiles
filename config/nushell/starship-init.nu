# this file is both a valid
# - overlay which can be loaded with `overlay use starship.nu`
# - module which can be used with `use starship.nu`
# - script which can be used with `source starship.nu`
export-env { load-env {
    STARSHIP_SHELL: "nu"
    STARSHIP_SESSION_KEY: (random chars -l 16)
    PROMPT_MULTILINE_INDICATOR: (
        ^starship prompt --continuation
    )

    # Does not play well with default character module.
    # TODO: Also Use starship vi mode indicators?
    PROMPT_INDICATOR: ""

    PROMPT_COMMAND: {||
        # jobs are not supported
        (
            ^starship prompt
                --cmd-duration $env.CMD_DURATION_MS
                --terminal-width (term size).columns
        )
    }

    config: ($env.config? | default {} | merge {
        render_right_prompt_on_last_line: true
    })

    PROMPT_COMMAND_RIGHT: {|| }

    PROMPT_INDICATOR_VI_NORMAL: {|| $"\b\b(if $env.LAST_EXIT_CODE != 0 { ansi rb } else { ansi gb }) (ansi reset)" }
    PROMPT_INDICATOR_VI_INSERT: {|| $"\b\b(if $env.LAST_EXIT_CODE != 0 { ansi rb } else { ansi gb }) (ansi reset)" }
}}
