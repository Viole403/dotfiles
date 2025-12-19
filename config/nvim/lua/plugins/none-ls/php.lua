local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- prettierd just for php formatting
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "php" },
    }),

    -- phpcsfixer final authority
    null_ls.builtins.formatting.phpcsfixer.with({
      filetypes = { "php" },
      extra_args = {
        "--rules=@PSR12",
        "--using-cache=no",
      },
    }),
  },
})
