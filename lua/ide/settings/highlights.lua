local status_ok, colors =
    pcall(require, "ide.plugins.ui.colors")
if not status_ok then
    vim.notify("error in highlights.lua")
    return
end

vim.api.nvim_set_hl(
    0,
    "Normal",
    { fg = colors.white, bg = colors.black }
)
vim.api.nvim_set_hl(
    0,
    "NormalFloat",
    { fg = colors.white, bg = colors.black }
)
vim.api.nvim_set_hl(
    0,
    "FloatBorder",
    { fg = colors.grey2, bg = colors.black }
)
vim.api.nvim_set_hl(
    0,
    "WhichKeySeparator",
    { fg = colors.green_light }
)
vim.api.nvim_set_hl(0, "TelescopeNormal", {
    fg = colors.green_light,
})
vim.api.nvim_set_hl(0, "TelescopeBorder", {
    fg = colors.grey2,
})
vim.api.nvim_set_hl(0, "WhichKeyBorder", {
    fg = colors.grey2,
})
vim.api.nvim_set_hl(0, "WhichKeyFloat", {
    fg = "#ff0000",
    bg = colors.black,
})
vim.api.nvim_set_hl(0, "Pmenu", {
    fg = colors.white,
    bg = colors.black,
})
vim.api.nvim_set_hl(0, "PmenuSel", {
    fg = colors.green_light,
    bg = colors.grey0,
})
vim.api.nvim_set_hl(0, "Tabline", {
    fg = colors.white,
    bg = colors.black,
})
