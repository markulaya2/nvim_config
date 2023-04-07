local cursorline = Prequire("nvim-cursorline")

cursorline.setup({
    cursorline = {
        enable = true,
        timeout = 100,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    },
})
