local null_ls = Prequire("null-ls")

local augroup =
    vim.api.nvim_create_augroup("LspFormatting", {})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({
            extra_args = function(params)
                return params.options
                    and params.options.tabSize
                    and {
                        "--print-width",
                        80,
                        "--tab-width",
                        params.options.tabSize,
                        "--single-quote",
                        true,
                        "--jsx-single-quote",
                        true,
                    }
            end,
        }),
        formatting.black.with({
            extra_args = { "--fast" },
        }),
        formatting.stylua.with({
            extra_args = {
                "--quote-style",
                "AutoPreferDouble",
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
                "--column-width",
                "55",
                "--line-endings",
                "Unix",
                "call_parentheses",
                "Always",
            },
        }),
        diagnostics.eslint,
        -- diagnostics.flake8
    },
    on_attach = function(client, bufnr)
        if
            client.supports_method(
                "textDocument/formatting"
            )
        then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
