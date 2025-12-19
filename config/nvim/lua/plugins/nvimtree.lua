-- plugins/nvimtree.lua
return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          },
        },
      },
    })
  end
}
