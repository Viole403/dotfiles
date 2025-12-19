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
        "vim", "vimdoc", "bash", "lua", "python", "go", "java", "php", "rust", "html", "css", "json", "javascript", "typescript", "tsx", "yaml", "markdown",
        "scala", "org", "c", "ruby", "http"
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
