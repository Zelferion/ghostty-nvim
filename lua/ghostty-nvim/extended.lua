-- extended.lua
local M = {}

local function setup_highlights(theme)
    local highlights = {
        ["@function"] = { fg = theme.palette[2] },
        ["@operator"] = { fg = theme.palette[5] },
        ["@variable"] = { fg = theme.palette[7] },
        ["@punctuation"] = { fg = theme.palette[7] },
        ["@string.escape"] = { fg = theme.palette[12] },
        ["@keyword"] = { fg = theme.palette[5] },
        ["@keyword.function"] = { fg = theme.palette[12] },
        ["@string"] = { fg = theme.palette[10] },
        ["@comment"] = { fg = theme.palette[15], italic = true },
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
