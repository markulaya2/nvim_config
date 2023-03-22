-- automatically install packer
local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print(
        "installed packer\nclose and reopen neovim..."
    )
    vim.cmd([[packadd packer.nvim]])
end

-- require packer with pcall to avoid error on first use
local ok, packer = pcall(require, "packer")
if not ok then
    vim.notify("error in packer.lua")
    return
end

-- use a popup window for packer
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "rounded",
            })
        end,
    },
    git = {
        cmd = "git", -- The base command for git operations
        subcommands = { -- Format strings for git subcommands
            update = "pull --ff-only --progress --rebase=false",
            install = "clone --depth %i --no-single-branch --progress",
            fetch = "fetch --depth 999999 --progress",
            checkout = "checkout %s --",
            update_branch = "merge --ff-only @{u}",
            current_branch = "branch --show-current",
            diff = "log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD",
            diff_fmt = "%%h %%s (%%cr)",
            get_rev = "rev-parse --short HEAD",
            get_msg = "log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1",
            submodules = "submodule update --init --recursive --progress",
        },
        depth = 1, -- Git clone depth
        clone_timeout = 480, -- Timeout, in seconds, for git clones
        default_url_format = "https://github.com/%s", -- Lua format string used for "aaa/bbb" style plugins
    },
})

--reload neovim when packer.lua is saved
local _packer = vim.api.nvim_create_augroup(
    "_packer",
    { clear = true }
)

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer.lua",
    command = "source <afile>",
    group = _packer,
})

local dependencies = function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("MunifTanjim/nui.nvim")
end

local completion = function(use)
    --------------------------- cmp ---------------------------
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("hrsh7th/cmp-nvim-lsp") -- lsp completions
    use("hrsh7th/cmp-nvim-lua") -- nvim lua completions

    --------------------------- lsp ---------------------------
    --[[ use("ray-x/lsp_signature.nvim") ]]
    --[[ use("folke/trouble.nvim") ]]
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")

    --------------------------- null-ls -----------------------
    use("jose-elias-alvarez/null-ls.nvim") -- format/linting

    --------------------------- snippet -----------------------
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("rafamadriz/friendly-snippets") -- some snippets
end

local tools = function(use)
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })

    --------------------------- comment -----------------------
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("folke/todo-comments.nvim")

    --------------------------- misc --------------------------
    use("unblevable/quick-scope")
    use("nacro90/numb.nvim")
    use("ethanholz/nvim-lastplace")
    use("p00f/nvim-ts-rainbow")
    use("yamatsum/nvim-cursorline")
    use("norcalli/nvim-colorizer.lua")
    use("lukas-reineke/indent-blankline.nvim")
    use("windwp/nvim-autopairs")
    use("famiu/bufdelete.nvim")
    use("NTBBloodbath/rest.nvim")

    --------------------------- range-highlight ---------------
    use("winston0410/cmd-parser.nvim")
    use("winston0410/range-highlight.nvim")

    --------------------------- debugger ----------------------
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
end

local ui = function(use)
    use("rcarriga/nvim-notify")
    use("kyazdani42/nvim-tree.lua")
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
    })
    use("folke/which-key.nvim")
    use("akinsho/toggleterm.nvim")

    --------------------------- wilder ------------------------
    use("gelguy/wilder.nvim")
    use("nixprime/cpsm")

    --------------------------- telescope ---------------------
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use("ahmedkhalf/project.nvim")

    --------------------------- greeter -----------------------
    use("goolord/alpha-nvim")

    --------------------------- bufferline --------------------
    use("noib3/nvim-cokeline")

    --------------------------- statusline --------------------
    use("nvim-lualine/lualine.nvim")

    --------------------------- git ---------------------------
    use("lewis6991/gitsigns.nvim")

    --------------------------- colorscheme -------------------
    use("sainnhe/sonokai")

    --------------------------- scrollbar ---------------------
    use("petertriho/nvim-scrollbar")
end

-- install plugins
return packer.startup(function(use)
    dependencies(use)
    completion(use)
    tools(use)
    ui(use)

    --[[
    automatically set up your configuration
    after cloning packer.nvim
    put this at the end after all plugins
    --]]
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
