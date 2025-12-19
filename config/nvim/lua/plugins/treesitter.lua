-- plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash","lua","python","go","java","php","rust","html","css","json"
      },
      highlight = { enable = true },
    })
  end
}
