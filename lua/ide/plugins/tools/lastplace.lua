local nvim_lastplace = Prequire("nvim-lastplace")

nvim_lastplace.setup({
    lastplace_ignore_buftype = {
        "quickfix",
        "nofile",
        "help",
    },
    lastplace_ignore_filetype = {
        "gitcommit",
        "gitrebase",
        "svn",
        "hgcommit",
        "alpha",
    },
    lastplace_open_folds = true,
})
