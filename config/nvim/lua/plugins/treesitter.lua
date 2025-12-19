-- plugins/treesitter.lua
-- Treesitter configuration (synchronized with LunarVim config)
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, configs = pcall(require, 'nvim-treesitter.configs')
    if not ok then return end

    configs.setup {
      -- Core parsers synchronized with lvim config
      ensure_installed = {
        "bash", "lua", "python", "go", "java", "php", "rust", "html", "css", "json", "javascript", "typescript", "tsx", "yaml", "markdown"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end
}
