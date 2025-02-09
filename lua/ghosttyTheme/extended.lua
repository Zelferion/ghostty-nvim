local M = {}

local function setup_highlights(colors)
    local highlights = {
        ["@function"] = { fg = colors.fn_color },
        ["@variable"] = { fg = colors.var_color },
        ["@keyword"] = { fg = colors.keyword_color, bold = true },
        ["@string"] = { fg = colors.string_color },
        ["@comment"] = { fg = colors.comment_color, italic = true },
    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

function M.setup(opts)
    local ts_ok, _ = pcall(require, 'nvim-treesitter.configs')
    if not ts_ok then
        vim.notify("Treesitter not found. Highlighting features disabled.", vim.log.levels.WARN)
        return
    end

    local utils = require("ghosttyTheme.utils")

    local theme = utils.construct_theme_object

    local colors = vim.tbl_extend("force", {
        fn_color = theme.foreground,
        var_color = theme.foreground,
        keyword_color = theme.foreground,
        string_color = theme.foreground,
        comment_color = theme.foreground,
    }, opts.colors or {})

    setup_highlights(colors)

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            setup_highlights(colors)
        end,
    })
end

return M
