-- plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, configs = pcall(require, 'nvim-treesitter.configs')
    if not ok then return end

    configs.setup {
      -- Core parsers synchronized with lvim config
      ensure_installed = {
        "vim", "vimdoc", "bash", "lua", "python", "go", "java", "php", "rust",
        "html", "css", "json", "javascript", "typescript", "tsx", "yaml", "markdown",
        "scala", "org", "c", "ruby", "http"
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          -- Disable for large files or if parser not available
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    }

    -- Setup rainbow-delimiters separately (it's not a treesitter module)
    local rainbow_delimiters = require('rainbow-delimiters')

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
    }
  end
}