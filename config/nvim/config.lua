-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics {
--         virtual_text = true,
--         signs = true,
--         update_in_insert = true,
--     }
-- )
require("textcase").setup {}

require("neodev").setup {}
local lspc = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspc.ccls.setup {
    init_options = {
        index = {
            threads = 4,
        },
        -- compilationDatabaseDirectory = "build/",
    },
    filetypes = { "c", "cpp", "arduino" },
    -- cmd = { "ccls", "-log-file=/tmp/ccls.log", "-v=1"},
    capabilities = capabilities,
}
lspc.pyright.setup {
    capabilities = capabilities
}
lspc.texlab.setup {}
lspc.dhall_lsp_server.setup {}
-- lspc.ltex.setup {
--     default_config = {
--         cmd = { "ltex-ls" },
--         filetypes = { 'bib', 'gitcommit', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex' },
--         single_file_support = true,
--         get_language_id = function(_, filetype)
--             if filetype == "tex" then
--                 return "latex"
--             else
--                 return filetype
--             end
--         end,
--     },
-- }
require('rust-tools').setup {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = false,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        capabilities = capabilities,
        on_attach = function() end,
        settings = {
            ["rust-analyzer"] = {
                completion = {
                    addCallArgumentSnippets = true,
                },
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                    features = "all",
                },
                procMacro = {
                    enable = true
                },
            },
        },
    },
}

require("trouble").setup {}

require("todo-comments").setup {
    signs = true, -- show icons in the signs column
    -- keywords recognized as todo comments
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "HACK" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = " (KEYWORDS)([: ].+|$)",
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
        error = { "GruvboxRed" },
        warning = { "GruvboxYellow" },
        info = { "GruvboxBlue" },
        hint = { "GruvboxAqua" },
        default = { "Identifier" },
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        pattern = " (KEYWORDS)([: ].+|$)",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
}

local cmp = require 'cmp'
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})

require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "vim", "python", "cpp", "bash", "query", "norg", "norg_meta" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { "python", "yaml" },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next = {
                ["]a"] = "@conditional.outer",
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_previous = {
                ["[a"] = "@conditional.outer",
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
            }
        },
    },
}
require('nu').setup {}
-- require("lsp_lines").register_lsp_virtual_lines()
vim.diagnostic.config({
    virtual_text = false,
})

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
require('lualine').setup {
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
require("nvim-tree").setup()
local vobj = require("various-textobjs")
vobj.setup {
    lookForwardLines = 20,
    useDefaultKeymaps = true,
}
vim.keymap.set({"o", "x"}, "ii", function() vobj.indentation(true, true) end)
vim.keymap.set({"o", "x"}, "ai", function() vobj.indentation(false, true) end)
vim.keymap.set("n", "gx", function ()
	vobj.url() -- select URL
	local foundURL = vim.fn.mode():find("v") -- only switches to visual mode if found
	if foundURL then
		vim.cmd.normal { '"zy', bang = true } -- retrieve URL with "z as intermediary
		local url = vim.fn.getreg("z")
		os.execute("xdg-open '" .. url .. "'")
    else
        vim.cmd.UrlView("buffer")
	end
end, {desc = "Smart URL Opener"})

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = { "<c-s-u>", type = "command" },
                ["<C-b>"] = actions.preview_scrolling_up,
                ["<C-f>"] = actions.preview_scrolling_down,
            },
        },
    },
}
