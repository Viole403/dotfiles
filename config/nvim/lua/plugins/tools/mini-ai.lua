-- plugins/tools/mini-ai.lua
return {
  "echasnovski/mini.ai",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup()
  end,
}