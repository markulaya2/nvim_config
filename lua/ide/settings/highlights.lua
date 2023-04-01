local status_ok, colors =
    pcall(require, "ide.plugins.ui.colors")
if not status_ok then
    vim.notify("error in highlights.lua")
    return
end

vim.api.nvim_set_hl(0, "Normal", { bg = colors.black })
vim.api.nvim_set_hl(
    0,
    "NormalFloat",
    { bg = colors.black }
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
    bg = colors.black,
})
vim.api.nvim_set_hl(0, "Pmenu", {
    bg = colors.black,
})
vim.api.nvim_set_hl(0, "PmenuSel", {
    bg = colors.grey0,
})
