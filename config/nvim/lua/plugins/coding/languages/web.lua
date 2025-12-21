-- plugins/coding/languages/web.lua
return {
  "neovim/nvim-lspconfig",
  ft = { "html", "css", "json", "astro" },
  config = function()
    local lspconfig = require("lspconfig")
    local lsp = require("plugins.coding.lsp")

    for _, server in ipairs({ "html", "cssls", "jsonls", "astro" }) do
      lspconfig[server].setup({
        capabilities = lsp.common.get_capabilities(),
        on_attach = lsp.common.on_attach,
      })
    end

    -- Format on save with prettierd (handled by none-ls globally)
  end,
}
