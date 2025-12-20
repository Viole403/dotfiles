-- plugins/whichkey.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "classic",
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = false,
        },
      },
      icons = {
        breadcrumb = ">>",
        separator = "->",
        group = "+",
        mappings = false,  -- Disable icons for mappings
      },
      win = {  -- Ganti 'window' jadi 'win' (baru)
        border = "rounded",
        position = "bottom",
      },
    })
  end,
}