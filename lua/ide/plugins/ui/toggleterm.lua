local colors = require("ide.plugins.ui.colors")
local status_ok, toggleterm =
    pcall(require, "toggleterm")
if not status_ok then
    vim.notify("error in toggleterm")
    return
end

toggleterm.setup({
    size = 10,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = "zsh",
    float_opts = {
        border = "curved",
        winblend = 10,
    },
    highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
            link = "Normal",
        },
        NormalFloat = {
            link = "NormalFloat",
        },
        FloatBorder = {
            link = "FloatBorder",
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "<esc>",
        [[<C-\><C-n>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "jk",
        [[<C-\><C-n>]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "<C-h>",
        [[<C-\><C-n><C-W>h]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "<C-j>",
        [[<C-\><C-n><C-W>j]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "<C-k>",
        [[<C-\><C-n><C-W>k]],
        opts
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "t",
        "<C-l>",
        [[<C-\><C-n><C-W>l]],
        opts
    )
end

vim.cmd(
    "autocmd! TermOpen term://* lua set_terminal_keymaps()"
)

local Terminal =
    require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
})

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({
    cmd = "node",
    hidden = true,
})

function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({
    cmd = "ncdu",
    hidden = true,
})

function _NCDU_TOGGLE()
    ncdu:toggle()
end

local btm = Terminal:new({
    cmd = "btm",
    hidden = true,
})

function _BTM_TOGGLE()
    btm:toggle()
end

local python = Terminal:new({
    cmd = "python",
    hidden = true,
})

function _PYTHON_TOGGLE()
    python:toggle()
end

vim.g.terminal_color_0 = "#212529"
vim.g.terminal_color_8 = "#6C757D"
vim.g.terminal_color_1 = "#D16969"
vim.g.terminal_color_9 = "#D16969"
vim.g.terminal_color_2 = "#608B4E"
vim.g.terminal_color_10 = "#608B4E"
vim.g.terminal_color_3 = "#D7BA7D"
vim.g.terminal_color_11 = "#D7BA7D"
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_12 = colors.blue
vim.g.terminal_color_5 = "#C586C0"
vim.g.terminal_color_13 = "#C586C0"
vim.g.terminal_color_6 = "#9CDCFE"
vim.g.terminal_color_14 = "#9CDCFE"
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_15 = colors.white
