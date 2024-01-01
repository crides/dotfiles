local filename = {
    'filename',
    symbols = {
        modified = '+',
        readonly = '[RO]',
        unnamed = '[No Name]',
        newfile = '[New]',
    }
}

local gruvbox = require("lualine.themes.gruvbox")
for _, mode in ipairs({"insert", "visual", "command", "replace"}) do
    gruvbox[mode].b = gruvbox.normal.b
    gruvbox[mode].c = gruvbox.normal.c
end
local z_style = { fg = gruvbox.normal.a.fg, bg = gruvbox.normal.a.bg }
for _, mode in ipairs({"normal", "insert", "visual", "command", "replace", "inactive"}) do
    gruvbox[mode].z = z_style
end

-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})

return {
    options = {
        theme = gruvbox,
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {filename},
        lualine_c = {
            {
                'branch',
                icons_enabled = false,
            },
            'diff',
            {
                'diagnostics',
                sections = { 'error', 'warn' },
            },
            'trouble',
            require('lsp-progress').progress,
        },
        lualine_x = {
            'encoding',
            {
                'fileformat',
                symbols = {
                    unix = ' ', -- e712
                    dos = ' ',  -- e70f
                    mac = ' ',  -- e711
                },
            },
            'filetype',
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_c = {filename},
        lualine_x = {'progress'},
        lualine_y = {'location'},
    },
    tabline = {
        lualine_c = {
            {
                'tabs',
                mode = 2,
                max_length = vim.o.columns,
                tabs_color = { active = gruvbox.normal.z, inactive = gruvbox.normal.b },
            },
        },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
