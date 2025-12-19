-- lua/plugins/terminal.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 10,
      open_mapping = [[<A-`>]],
      direction = "horizontal",
      shade_terminals = false,
      start_in_insert = true,
      persist_size = true,
    })
  end
}
