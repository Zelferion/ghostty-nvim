local function read_theme_name(config_path)
    local file = io.open(config_path, "r")
    if not file then
        error("Could not open config file: " .. config_path)
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
        error("Theme name not found in config file: " .. config_path)
    end

    return theme_name
end

local function parse_theme_file(theme_path)
    local file = io.open(theme_path, "r")
    if not file then
        error("Could not open theme file: " .. theme_path)
    end

    local theme = {}
    for line in file:lines() do
        local palette_index, palette_color = line:match("^palette%s*=%s*(%d+)=(%S+)$")
        if palette_index and palette_color then
            theme.palette = theme.palette or {}
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

local function construct_theme_object()
    local config_path = os.getenv("HOME") .. "/.config/ghostty/config"
    local theme_name = read_theme_name(config_path)

    local theme_path = "/usr/share/ghostty/themes/" .. theme_name
    local theme = parse_theme_file(theme_path)

    return theme
end
