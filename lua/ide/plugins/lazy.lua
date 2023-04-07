local lazypath = vim.fn.stdpath("data")
    .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- require lazy with pcall to avoid error on first use
local ok, lazy = pcall(require, "lazy")
if not ok then
    vim.notify("error in packer.lua")
    return
end

local merge = function(...)
    local result = {}
    for i = 1, select("#", ...) do
        local tbl = select(i, ...)
        for j = 1, #tbl do
            table.insert(result, tbl[j])
        end
    end
    return result
end

local dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
}

local completion = {
    -- cmp
    "hrsh7th/nvim-cmp", -- completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "hrsh7th/cmp-nvim-lsp", -- lsp completions
    "hrsh7th/cmp-nvim-lua", -- nvim lua completions

    -- lsp
    "ray-x/lsp_signature.nvim",
    "folke/trouble.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- null-ls
    "jose-elias-alvarez/null-ls.nvim", -- format/linting

    -- snippet
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets", -- some snippets
}

local tools = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- comment
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "folke/todo-comments.nvim",

    -- misc
    "nacro90/numb.nvim",
    "ethanholz/nvim-lastplace",
    "p00f/nvim-ts-rainbow",
    "yamatsum/nvim-cursorline",
    "norcalli/nvim-colorizer.lua",
    "lukas-reineke/indent-blankline.nvim",
    "windwp/nvim-autopairs",
    "famiu/bufdelete.nvim",
    "NTBBloodbath/rest.nvim",

    -- range-highlight
    "winston0410/cmd-parser.nvim",
    "winston0410/range-highlight.nvim",

    -- debugger
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
}

local ui = {
    "rcarriga/nvim-notify",
    "kyazdani42/nvim-tree.lua",
    "folke/which-key.nvim",
    "akinsho/toggleterm.nvim",

    -- wilder
    "gelguy/wilder.nvim",
    "nixprime/cpsm",

    -- telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "ahmedkhalf/project.nvim",

    -- greeter
    "goolord/alpha-nvim",

    -- bufferline
    "noib3/nvim-cokeline",

    -- statusline
    "nvim-lualine/lualine.nvim",

    -- git
    "lewis6991/gitsigns.nvim",

    -- colorscheme
    "sainnhe/sonokai",

    -- scrollbar
    "petertriho/nvim-scrollbar",
}

lazy.setup(merge(dependencies, completion, tools, ui), {
    install = {
        missing = true,
        colorscheme = { "sonokai", "habamax" },
    },
    git = {
        log = { "--since=3 days ago" }, -- show commits from the last 3 days
        timeout = 240,
        url_format = "https://github.com/%s.git",
        filter = true,
    },
    ui = {
        border = "rounded",
    },
})
