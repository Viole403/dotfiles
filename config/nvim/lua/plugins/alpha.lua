-- plugins/alpha.lua
return {
  "goolord/alpha-nvim",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = { "Neovim" }
    dashboard.section.buttons.val = {
      dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
      dashboard.button("q", "Quit", ":qa<CR>"),
    }
    require("alpha").setup(dashboard.config)
  end
}
