-- plugins/rainbow.lua
return {
  "HiPhish/rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPre",
}