-- utils.lua
local M = {}

function M.read_theme_name(config_path)
    local file = io.open(config_path, "r")
    if not file then
        error("Could not open Ghostty config file: " .. config_path)
    end

    local theme_name
    for line in file:lines() do
        if line:match("^theme%s*=%s*(.+)$") then
            theme_name = line:match("^theme%s*=%s*(.+)$")
            break
        end
    end

    file:close()

    if not theme_name then
        error("Theme name not found in Ghostty config file")
    end

    return theme_name
end

function M.parse_theme_file(theme_path)
    local file = io.open(theme_path, "r")
    if not file then
        error("Could not open Ghostty theme file: " .. theme_path)
    end

    local theme = {
        palette = {}
    }

    for line in file:lines() do
        local palette_index, palette_color = line:match("^palette%s*=%s*(%d+)=(%S+)$")
        if palette_index and palette_color then
            theme.palette[tonumber(palette_index)] = palette_color
        else
            local key, value = line:match("^(%S+)%s*=%s*(.+)$")
            if key and value then
                theme[key] = value
            end
        end
    end

    file:close()
    return theme
end

function M.construct_theme_object()
    local config_path = os.getenv("HOME") .. "/.config/ghostty/config"
    local theme_name = M.read_theme_name(config_path)
    
    local theme_path = "/usr/share/ghostty/themes/" .. theme_name
    local theme = M.parse_theme_file(theme_path)
    
    return theme
end

return M
