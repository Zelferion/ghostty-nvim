local M = {}

local function has_dependency(plugin_name)
    return pcall(require, plugin_name)
end

function M.setup(opts)
    opts = opts or {
        enabled = true,
        treesitter = true,
        theme = {
            background = "",
            foreground = "",
        },
    }

    if opts.enabled then
        local core = require("ghosttyTheme.core")
        core.setup(opts)

        if has_dependency("nvim-treesitter/nvim-treesitter") then
            local extended = require("ghosttyTheme.extended")
            extended.setup(opts)
        else
            if opts.require_dependency then
                vim.notify("Required dependency 'nvim-treesitter/nvim-treesitter' not found", vim.log.levels.ERROR)
                return
            end
            vim.notify("Running in basic mode without 'nvim-treesitter/nvim-treesitter'", vim.log.levels.INFO)
        end
    end
end

return M
