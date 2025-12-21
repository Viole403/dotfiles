-- plugins/coding/neogen.lua
return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        python = { template = { annotation_convention = "google_docstrings" } },
        go = { template = { annotation_convention = "godoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
        javascript = { template = { annotation_convention = "jsdoc" } },
        javascriptreact = { template = { annotation_convention = "jsdoc" } },
        rust = { template = { annotation_convention = "rustdoc" } },
        lua = { template = { annotation_convention = "ldoc" } },
      },
    })

    vim.keymap.set("n", "<leader>nf", ":Neogen func<CR>", { desc = "Generate function doc" })
    vim.keymap.set("n", "<leader>nc", ":Neogen class<CR>", { desc = "Generate class doc" })
    vim.keymap.set("n", "<leader>nt", ":Neogen type<CR>", { desc = "Generate type doc" })
  end,
}