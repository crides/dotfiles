# Nushell Environment Config File
use std

std path add [
    "~/.local/bin"
    "~/.cargo/bin"
]

load-env {
    SHELL: $nu.current-exe
    NU_LIB_DIRS: [
        ($nu.config-path | path dirname | path join 'scripts')
    ]
    BROWSER: "~/gitproj/qutebrowser/qutebrowser.py"
    # Zephyr
    ZEPHYR_TOOLCHAIN_VARIANT: "gnuarmemb"
    GNUARMEMB_TOOLCHAIN_PATH: "/usr"
    DFT_PARSE_ERROR_LIMIT: 500          # cpp..
    DFT_SYNTAX_HIGHLIGHT: on
    DFT_COLOR: always
}

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
# $env.NU_PLUGIN_DIRS = [
#     ($nu.config-path | path dirname | path join 'plugins')
# ]

# $env.PATH = ($env.PATH | prepend '/some/path')
