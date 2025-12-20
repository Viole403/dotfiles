-- plugins/whichkey.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- leave empty to use default settings
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}