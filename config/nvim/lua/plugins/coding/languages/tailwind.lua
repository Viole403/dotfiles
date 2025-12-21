-- plugins/coding/languages/tailwind.lua
return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "vue", "svelte" },
  opts = {
    server = {
      override = true,
    },
    document_color = {
      enabled = true,
      kind = "inline",
      inline_symbol = "󰝤 ",
    },
    conceal = {
      enabled = false,
    },
  },
}
