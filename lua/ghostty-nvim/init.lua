
local M = {}


local current_opts = nil


local function apply_theme(opts)
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


function M.reload()
    if current_opts then
        vim.notify("Reloading Ghostty theme...", vim.log.levels.INFO)
        apply_theme(current_opts)
        vim.notify("Ghostty theme reloaded!", vim.log.levels.INFO)
    else
        vim.notify("Theme not initialized. Call setup() first.", vim.log.levels.ERROR)
    end
end

function M.setup(opts)
    opts = opts or {
        enabled = true,
        treesitter = true,
    }
    
    
    current_opts = opts
    
    apply_theme(opts)

    
    if opts.reload_keymap ~= false then  
        local keymap = opts.reload_keymap or "<leader>tr"  
        vim.keymap.set('n', keymap, M.reload, { 
            desc = "Reload Ghostty theme", 
            silent = true 
        })
    end
end

return M
