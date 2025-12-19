-- plugins/alpha.lua
return {
  "goolord/alpha-nvim",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = { "Neovim" }
    dashboard.section.buttons.val = {
      dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
      dashboard.button("n", "New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("t", "Find Text", ":Telescope live_grep<CR>"),
      dashboard.button("p", "Projects", ":Telescope projects<CR>"),
      dashboard.button("s", "Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "Quit", ":qa<CR>"),
    }
    require("alpha").setup(dashboard.config)
  end
}
