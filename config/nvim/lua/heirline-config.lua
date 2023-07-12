local utils = require("heirline.utils")
local cond = require("heirline.conditions")

local dim_bg = utils.get_highlight("GruvboxBg2").fg
local gray_bg = utils.get_highlight("GruvboxBg3").fg

local colors = {
    bright_bg = utils.get_highlight("GruvboxFg2").bg,
    bright_fg = utils.get_highlight("GruvboxFg2").fg,
    red = utils.get_highlight("GruvboxRed").fg,
    dark_red = utils.get_highlight("GruvboxRedSign").bg,
    green = utils.get_highlight("GruvboxGreen").fg,
    blue = utils.get_highlight("GruvboxBlue").fg,
    gray = utils.get_highlight("GruvboxBlue").fg,
    orange = utils.get_highlight("GruvboxOrange").fg,
    purple = utils.get_highlight("GruvboxPurple").fg,
    cyan = utils.get_highlight("GruvboxAqua").fg,
    diag_warn = utils.get_highlight("GruvboxYellow").fg,
    diag_error = utils.get_highlight("GruvboxRed").fg,
    diag_hint = utils.get_highlight("GruvboxBlue").fg,
    diag_info = utils.get_highlight("GruvboxGreen").fg,
    git_del = utils.get_highlight("GruvboxRed").fg,
    git_add = utils.get_highlight("GruvboxGreen").fg,
    git_change = utils.get_highlight("GruvboxAqua").fg,
}

local vi_mode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = "N",
            no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            V = "V_",
            vs = "Vs", Vs = "Vs",
            ["\22"] = "^V", ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv", Rvc = "Rv", Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
    },
    provider = function(self)
        return " %-2("..self.mode_names[self.mode].."%) "
    end,
    hl = function(self)
        return { fg = "bg", bg = self:mode_color(), bold = true }
    end,
}

local filename_block = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = gray_bg },
}
-- We can now define some children separately and add them later

local filename = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not cond.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return " " .. filename
    end,
    hl = { fg = "bright_fg" },
}

local file_flags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+] ",
        hl = { fg = "bright_fg" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "  ",
        hl = { fg = "orange" },
    },
    {
        condition = function()
            return not vim.bo.modified and not (not vim.bo.modifiable or vim.bo.readonly)
        end,
        provider = " ",
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the filename.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local filename_mod = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force = true }
        end
    end,
}

filename_block = utils.insert(filename_block,
    utils.insert(filename_mod, filename), -- a new table where filename is a child of FileNameModifier
    file_flags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

local left = {
    vi_mode,
    { provider = "", hl = function(self) return { fg = self:mode_color() } end },
    -- utils.surround({ "", "" }, function(self) return { fg = self:mode_color() } end, vi_mode),
    hl = { bg = gray_bg },
}

local left_mid = {
    utils.surround({ "", "" }, gray_bg, filename_block),
    hl = { bg = dim_bg },
}

local statusline = {
    left,
    left_mid,
    static = {
        mode_colors = {
            n = "bright_fg",
            i = "cyan",
            v = "orange",
            V = "orange",
            ["\22"] = "orange",
            c = "green",
            R = "red",
            r = "red",
            ["!"] =  "purple",
            t = "bright_fg",
        },
        mode_color = function(self)
            local mode = cond.is_active() and vim.fn.mode() or "n"
            return self.mode_colors[mode]
        end,
    },
}

return {
    statusline = statusline,
    opts = {
        colors = colors,
    },
}
