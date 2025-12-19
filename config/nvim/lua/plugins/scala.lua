return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt" },
  config = function()
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = {},
    }

    metals_config.capabilities =
      require("cmp_nvim_lsp").default_capabilities()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
    })
  end,
}
