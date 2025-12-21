-- plugins/coding/languages/php.lua
return {
  "neovim/nvim-lspconfig",
  ft = "php",
  config = function()
    local lspconfig = require("lspconfig")
    local lsp = require("plugins.coding.lsp")

    lspconfig.intelephense.setup({
      capabilities = lsp.common.get_capabilities(),
      on_attach = lsp.common.on_attach,
    })

    -- Format on save with phpcsfixer (handled by none-ls globally)
  end,
}
