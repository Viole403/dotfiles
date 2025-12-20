-- plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      toggler = {
        line = "gcc",   -- Keep line comment
        block = "gbc",  -- Keep block comment
      },
      opleader = {
        line = "gc",    -- Operator-pending mode
        block = "gb",   -- Operator-pending mode
      },
      mappings = {
        basic = true,
        extra = false,  -- Disable extra mappings to avoid conflicts
      },
    })
  end,
}