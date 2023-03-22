local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

---[[General Settings
local _general_settings = create_augroup(
    "_general_settings",
    { clear = true }
)

create_autocmd("FileType", {
    pattern = "qf,help,man,lspinfo",
    command = "nnoremap <silent> <buffer> q :close<CR>",
    group = _general_settings,
})

create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", {
            link = "Yellow",
        })
    end,
    group = _general_settings,
})

create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        require("vim.highlight").on_yank({
            higroup = "Search",
            timeout = 200,
        })
    end,
    group = _general_settings,
})

create_autocmd("BufWinEnter", {
    pattern = "*",
    command = ":set formatoptions-=cro",
    group = _general_settings,
})

create_autocmd("FileType", {
    pattern = "qf",
    command = "set nobuflisted",
    group = _general_settings,
})

create_autocmd("FileType", {
    pattern = "dart",
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
    group = _general_settings,
})
--]]

---[[Git
local _git = create_augroup("_git", { clear = true })

create_autocmd("FileType", {
    pattern = "gitcommit",
    command = "setlocal wrap",
    group = _git,
})

create_autocmd("FileType", {
    pattern = "gitcommit",
    command = "setlocal spell",
    group = _git,
})
--]]

---[[Markdown
local _markdown = create_augroup(
    "_markdown",
    { clear = true }
)

create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal wrap",
    group = _markdown,
})

create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal spell",
    group = _markdown,
})
--]]

---[[Auto Resize
local _auto_resize = create_augroup(
    "_auto_resize",
    { clear = true }
)

create_autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
    group = _auto_resize,
})
--]]

---[[Alpha
local _alpha = create_augroup(
    "_alpha",
    { clear = true }
)

create_autocmd("User", {
    pattern = "AlphaReady",
    command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
    group = _alpha,
})
--]]
