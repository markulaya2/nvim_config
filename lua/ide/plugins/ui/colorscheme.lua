local colorscheme = "sonokai"
local colors = require("ide.plugins.ui.colors")

local setup = {
    sonokai_style = "atlantis",
    sonokai_better_performance = 1,
    sonokai_enable_italic = 1,
    sonokai_diagnostic_text_highlight = 1,
    sonokai_diagnostic_line_highlight = 1,
    sonokai_diagnostic_virtual_text = "colored",
    sonokai_transparent_background = 1,
    sonokai_colors_override = {
        black = { colors.grey1, "235" },
        bg0 = { colors.black, "235" },
        bg1 = { colors.grey0, "236" },
        bg2 = { colors.grey0, "236" },
        bg3 = { colors.grey0, "237" },
        bg4 = { colors.grey2, "237" },
        bg_red = { colors.red, "237" },
        diff_red = { "#55393d", "237" },
        bg_green = { colors.green, "237" },
        diff_green = { "#394634", "237" },
        bg_blue = { colors.blue, "237" },
        diff_blue = { "#354157", "237" },
        diff_yellow = { "#4e432f", "237" },
        fg = { colors.white, "237" },
        red = { colors.red_light, "203" },
        orange = { colors.orange_light, "215" },
        yellow = { colors.yellow_light, "179" },
        green = { colors.green_light, "107" },
        blue = { colors.blue_light, "110" },
        purple = { colors.purple_light, "176" },
        grey = { colors.grey2, "237" },
        grey_dim = { colors.grey1, "237" },
        none = { "NONE", "NONE" },
    },
}

for k, v in pairs(setup) do
    vim.g[k] = v
end

local status_ok, _ =
    pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify(
        "colorscheme " .. colorscheme .. " not found!"
    )
    return
end
