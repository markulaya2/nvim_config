-- Setup nvim-cmp.
local npairs = Prequire("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
    },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub(
            [[ [%'%"%)%>%]%)%}%,] ]],
            "%s+",
            ""
        ),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})

local cmp_autopairs =
    Prequire("nvim-autopairs.completion.cmp")

local cmp = Prequire("cmp")

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        map_char = { tex = "" },
    })
)
