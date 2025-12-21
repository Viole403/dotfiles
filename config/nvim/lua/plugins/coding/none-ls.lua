-- plugins/coding/none-ls.lua
-- Global formatting setup with none-ls
-- Language-specific configs handle when to format
-- Required external tools: npm i -g prettierd, pip install black, go install mvdan.cc/gofumpt@latest, composer global require friendsofphp/php-cs-fixer
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- Web (JS/TS/React/Vue/Astro/HTML/CSS/JSON)
        null_ls.builtins.formatting.prettierd,

        -- Python
        null_ls.builtins.formatting.black,

        -- PHP
        null_ls.builtins.formatting.phpcsfixer,

        -- Note: Go uses go.nvim's goimport
        -- Note: Rust uses rustfmt via rust-analyzer
      },
      -- Global format on save (can be overridden per language)
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
