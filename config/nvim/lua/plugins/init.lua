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
  -- UI
  require("plugins.ui.alpha"),
  require("plugins.ui.bufferline"),
  require("plugins.ui.catppuccin"),
  require("plugins.ui.lualine"),
  require("plugins.ui.scrollbar"),

  -- Editor
  require("plugins.editor.autopairs"),
  require("plugins.editor.comment"),
  require("plugins.editor.flash"),
  require("plugins.editor.indent"),
  require("plugins.editor.rainbow"),
  require("plugins.editor.todo-comments"),
  require("plugins.editor.colorizer"),
  require("plugins.editor.illuminate"),
  require("plugins.editor.surround"),
  require("plugins.editor.yanky"),

  -- Navigation
  require("plugins.navigation.nvimtree"),
  require("plugins.navigation.telescope"),
  require("plugins.navigation.trouble"),
  require("plugins.navigation.project"),
  require("plugins.navigation.oil"),
  require("plugins.navigation.spectre"),

  -- Coding (shared tools)
  require("plugins.coding.cmp"),
  require("plugins.coding.lsp"),
  require("plugins.coding.none-ls"),
  require("plugins.coding.treesitter"),
  require("plugins.coding.gitsigns"),
  require("plugins.coding.neogen"),
  require("plugins.coding.neotest"),
  require("plugins.coding.dap"),

  -- Languages (LSP + formatters + language-specific tools)
  require("plugins.coding.languages.go"),
  require("plugins.coding.languages.rust"),
  require("plugins.coding.languages.typescript"),
  require("plugins.coding.languages.python"),
  require("plugins.coding.languages.php"),
  require("plugins.coding.languages.lua"),
  require("plugins.coding.languages.deno"),
  require("plugins.coding.languages.web"),
  require("plugins.coding.languages.scala"),
  require("plugins.coding.languages.tailwind"),
  require("plugins.tools.dadbod"),
  require("plugins.tools.rest"),
  require("plugins.tools.terminal"),
  require("plugins.tools.tmux"),
  require("plugins.tools.wakatime"),
  require("plugins.tools.minimap"),
  require("plugins.tools.markdown-preview"),
  require("plugins.tools.package-info"),
  require("plugins.tools.persistence"),
  require("plugins.tools.whichkey"),
  require("plugins.tools.mini-ai"),
}, {
  -- Disable luarocks support to avoid build issues
  rocks = {
    enabled = false,
  },
})
