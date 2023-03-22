local status_ok, colors =
    pcall(require, "ide.plugins.ui.colors")
if not status_ok then
    vim.notify("error in highlights.lua")
    return
end

vim.api.nvim_set_hl(
    0,
    "WhichKeySeparator",
    { fg = colors.green_light }
)
vim.api.nvim_set_hl(
    0,
    "TelescopeNormal",
    { fg = colors.green_light, bg = "#191d20" }
)
vim.api.nvim_set_hl(
    0,
    "TelescopeBorder",
    { fg = colors.grey2, bg = "#191d20" }
)
vim.api.nvim_set_hl(
    0,
    "WhichKeyBorder",
    { fg = colors.grey2, bg = "#191d20" }
)
vim.api.nvim_set_hl(
    0,
    "NotifyINFOBody",
    { bg = "#191d20" }
)
