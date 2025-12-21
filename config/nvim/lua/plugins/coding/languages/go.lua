-- plugins/coding/languages/go.lua
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      local lsp = require("plugins.coding.lsp")

      require("go").setup({
        -- Disable go.nvim's LSP, we'll use gopls directly
        lsp_cfg = {
          capabilities = lsp.common.get_capabilities(),
          on_attach = lsp.common.on_attach,
          settings = {
            gopls = {
              staticcheck = true,
              analyses = { unusedparams = true },
              gofumpt = true,
            },
          },
        },
        lsp_gofumpt = true,
        dap_debug = true,
        dap_debug_gui = true,
      })

      -- Auto format + organize imports on save (go.nvim handles this)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
      })
    end,
  },
}
