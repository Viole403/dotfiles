-- plugins/formatting.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("none-ls")
  end,
}
