local options = {
    number = true, -- line numbers
    relativenumber = true, -- relative line numbers
    tabstop = 4, -- tab length
    shiftwidth = 4, -- indentation length
    expandtab = true, -- convert tabs to spaces
    cmdheight = 1, -- neovim command line height
    fileencoding = "utf-8", -- encoding written to a file
    ignorecase = true, -- ignore case in search
    smartcase = true, -- smart case
    mouse = "a", -- allow the mouse to be used
    pumheight = 10, -- pop up menu height
    showtabline = 2, -- always show tabs
    cursorline = true, -- highlight current line
    wrap = true, -- line wrapping
    whichwrap = "b,s,<,>,[,],h,l",
    showmode = false, -- hide show mode
    numberwidth = 2, -- set number column width
    timeoutlen = 350, -- mapped sequence wait time
    conceallevel = 0, -- `` visible in MD files
    pumblend = 10, -- translucent popups
    winblend = 10, -- translucent floating windows
    laststatus = 3, -- global statusbar
    fillchars = "eob: ", -- hide ~
    splitright = true,
    linebreak = true,
    breakindent = true,
    showbreak = "",
    termguicolors = true,
    wildignore = "*/node_modules/*",
}

-- add options to vim.opt
for k, v in pairs(options) do
    vim.opt[k] = v
end

local HOME = os.getenv("HOME")
local python3 = HOME
    .. "/.pyenv/versions/nvim/bin/python3"

-- vim.g options
local g_options = {
    python3_host_prog = python3,
    mapleader = " ",
    maplocalleader = " ",
}

-- add options to vim.g
for k, v in pairs(g_options) do
    vim.g[k] = v
end
