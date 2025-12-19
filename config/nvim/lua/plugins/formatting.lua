-- lua/plugins/formatting.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd.with({
          filetypes = {
            "html", "vue", "css", "scss",
            "typescript", "typescriptreact", "php",
          },
        }),
        null_ls.builtins.formatting.scalafmt,
      },
    })
  end
}
