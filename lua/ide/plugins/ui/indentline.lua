local status_ok, indent_blankline =
    pcall(require, "indent_blankline")
if not status_ok then
    vim.notify("error in indentline")
    return
end

local colors = require("ide.plugins.ui.colors")

vim.g.indent_blankline_buftype_exclude =
    { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
}
vim.g.indentLine_enabled = 1
-- vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_char = "▎"
vim.g.indent_blankline_show_trailing_blankline_indent =
    false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
}
-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent1",
    { fg = colors.blue }
)
vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent2",
    { fg = colors.red }
)
vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent3",
    { fg = colors.yellow }
)
vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent4",
    { fg = colors.green }
)
vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent5",
    { fg = colors.orange }
)
vim.api.nvim_set_hl(
    0,
    "IndentBlanklineIndent6",
    { fg = colors.purple }
)

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"

indent_blankline.setup({
    -- show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = false,
    -- show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
})
