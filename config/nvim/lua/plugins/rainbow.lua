return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    local rainbow = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
      },
    }
  end,
}
