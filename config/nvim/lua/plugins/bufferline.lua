-- plugins/bufferline.lua
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    })
  end,
}
