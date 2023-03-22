local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap("","<Space>","<Nop>",opts)
vim.api.nvim_set_keymap(
    "n",
    "gl",
    [[
    <cmd>
        lua vim.diagnostic.open_float(0, {
            scope = "line",
            border = "single"
        })
    <CR>
    ]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "K",
    [[
    <cmd>
        lua vim.lsp.buf.hover()
    <CR>
    ]],
    { noremap = true, silent = true }
)
