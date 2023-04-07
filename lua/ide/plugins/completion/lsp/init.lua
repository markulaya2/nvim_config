local _ = Prequire("lspconfig")

require("ide.plugins.completion.lsp.mason")
require("ide.plugins.completion.lsp.handlers").setup()
require("ide.plugins.completion.lsp.null-ls")
require("ide.plugins.completion.lsp.trouble")
require("ide.plugins.completion.lsp.lsp_signature")
