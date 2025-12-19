local null_ls = require("null-ls")

null_ls.register({
  name = "prettierd",
  method = null_ls.methods.FORMATTING,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "html",
    "css",
    "scss",
    "vue",
    "astro",
  },
  generator = null_ls.builtins.formatting.prettierd.generator,
})
