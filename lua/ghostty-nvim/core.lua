-- core.lua
local M = {}

local function setup_highlights(theme)
    local highlights = {
        Normal         = { fg = theme.foreground, bg = "NONE" },
        Comment        = { fg = theme.palette[15] },
        String         = { fg = theme.palette[10] },
        Character      = { fg = theme.palette[4] },
        Number         = { fg = theme.palette[4] },
        Boolean        = { fg = theme.palette[4] },
        Float          = { fg = theme.palette[4] },
        Identifier     = { fg = theme.palette[7] },
        Function       = { fg = theme.palette[2] },
        Statement      = { fg = theme.palette[5] },
        Conditional    = { fg = theme.palette[3] },
        Repeat         = { fg = theme.palette[3] },
        Label          = { fg = theme.palette[3] },
        Operator       = { fg = theme.palette[6] },
        Keyword        = { fg = theme.palette[5] },
        Exception      = { fg = theme.palette[9] },
        PreProc        = { fg = theme.palette[13] },
        Include        = { fg = theme.palette[13] },
        Define         = { fg = theme.palette[13] },
        Macro          = { fg = theme.palette[13] },
        PreCondit      = { fg = theme.palette[13] },
        Type           = { fg = theme.palette[12] },
        StorageClass   = { fg = theme.palette[12] },
        Structure      = { fg = theme.palette[12] },
        Typedef        = { fg = theme.palette[12] },
        Special        = { fg = theme.palette[12] },
        SpecialChar    = { fg = theme.palette[10] },
        Tag           = { fg = theme.palette[4] },
        Delimiter      = { fg = theme.palette[6] },
        SpecialComment = { fg = theme.palette[8] },
        Debug          = { fg = theme.palette[9] },
        Underlined     = { fg = theme.palette[12], underline = true },
        Ignore         = { fg = theme.palette[7] },
        Error          = { fg = theme.palette[9] },
        Todo           = { fg = theme.palette[11] },
    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

function M.setup(opts)
    local utils = require("ghostty-nvim.utils")
    local theme = utils.construct_theme_object()

    setup_highlights(theme)

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            setup_highlights(theme)
        end,
    })
end

return M
