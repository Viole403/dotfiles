-- lua/plugins/none-ls.lua
-- none-ls is a bridge, not a wizard. It requires external tools to be installed.
-- Required tools (install via npm/pip/go/composer):
--   npm i -g prettierd
--   go install mvdan.cc/gofumpt@latest
--   go install golang.org/x/tools/cmd/goimports@latest
--   pip install black
--   composer global require friendsofphp/php-cs-fixer
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- JS / TS / Astro / React / Next / Bun
        null_ls.builtins.formatting.prettierd,

        -- Python
        null_ls.builtins.formatting.black,

        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,

        -- PHP / Laravel / CodeIgniter
        null_ls.builtins.formatting.phpcsfixer,
      },
      -- Format on save
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
