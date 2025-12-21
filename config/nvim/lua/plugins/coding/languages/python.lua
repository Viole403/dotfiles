-- plugins/coding/languages/python.lua
return {
  "neovim/nvim-lspconfig",
  ft = "python",
  config = function()
    local lspconfig = require("lspconfig")
    local lsp = require("plugins.coding.lsp")

    lspconfig.pyright.setup({
      capabilities = lsp.common.get_capabilities(),
      on_attach = lsp.common.on_attach,
    })

    -- Format on save with black (handled by none-ls globally)
  end,
}
