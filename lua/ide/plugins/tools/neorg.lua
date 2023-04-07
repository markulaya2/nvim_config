local neorg = Prequire("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    spirituality = "~/Neorg/spirituality",
                    knowledge = "~/Neorg/knowledge",
                    neorg = "~/Neorg/neorg",
                },
            },
        },
        ["core.norg.concealer"] = {
            config = {
                -- Configuration here
            },
        },
    },
})
