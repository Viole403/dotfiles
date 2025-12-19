local null_ls = require("null-ls")

null_ls.setup({
  sources = {},
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

require("plugins.none-ls.web")
require("plugins.none-ls.php")
require("plugins.none-ls.go")
require("plugins.none-ls.rust")
require("plugins.none-ls.python")
