# Nushell Environment Config File

$env.SHELL = "/usr/bin/nu"
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
# $env.NU_PLUGIN_DIRS = [
#     ($nu.config-path | path dirname | path join 'plugins')
# ]

# $env.PATH = ($env.PATH | prepend '/some/path')
