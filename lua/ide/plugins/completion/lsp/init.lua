local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("ide.plugins.completion.lsp.mason")
require("ide.plugins.completion.lsp.handlers").setup()
require("ide.plugins.completion.lsp.null-ls")

