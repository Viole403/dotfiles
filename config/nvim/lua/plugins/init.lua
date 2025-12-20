-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim with all plugins
require("lazy").setup({
  -- Core UI
  require("plugins.alpha"),
  require("plugins.bufferline"),
  require("plugins.catppuccin"),
  require("plugins.lualine"),

  -- File Management
  require("plugins.nvimtree"),
  require("plugins.project"),
  require("plugins.telescope"),

  -- Code Features
  require("plugins.autopairs"),
  require("plugins.cmp"),
  require("plugins.comment"),
  require("plugins.flash"),
  require("plugins.gitsigns"),
  require("plugins.indent"),
  require("plugins.lsp"),
  require("plugins.minimap"),
  require("plugins.none-ls"),
  require("plugins.rainbow"),
  require("plugins.scrollbar"),
  require("plugins.todo-comments"),
  require("plugins.treesitter"),
  require("plugins.trouble"),
  require("plugins.whichkey"),

  -- Language-specific
  require("plugins.scala"),

  -- Utilities
  require("plugins.dadbod"),
  require("plugins.illuminate"),
  require("plugins.rest"),
  require("plugins.terminal"),
  require("plugins.tmux"),
  require("plugins.wakatime"),
}, {
  -- Disable luarocks support to avoid build issues
  rocks = {
    enabled = false,
  },
})
