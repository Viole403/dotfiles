local null_ls = require("null-ls")

null_ls.register({
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
})
