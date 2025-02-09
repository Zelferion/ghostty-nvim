-- init.lua
local M = {}

function M.setup(opts)
    opts = opts or {
        enabled = true,
        treesitter = true,
    }

    if opts.enabled then
        local core = require("ghostty-nvim.core")
        core.setup(opts)

        local has_ts = pcall(require, "nvim-treesitter")
        if has_ts then
            local extended = require("ghostty-nvim.extended")
            extended.setup(opts)
        else
            if opts.treesitter then
                vim.notify("Treesitter not found. Some highlighting features disabled.", vim.log.levels.WARN)
            end
        end
    end
end

return M
