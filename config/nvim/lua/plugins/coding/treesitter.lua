-- plugins/coding/treesitter.lua
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
        "scala", "org", "c", "ruby", "http", "toml", "markdown_inline", "query"
      },

      sync_install = false,
      auto_install = true,
      ignore_install = { "phpdoc" },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }

    -- Setup rainbow-delimiters with pcall to avoid errors if not installed
    local rainbow_ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
    if rainbow_ok then
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
          lua = rainbow_delimiters.strategy['global'],
          python = rainbow_delimiters.strategy['global'],
          go = rainbow_delimiters.strategy['global'],
          rust = rainbow_delimiters.strategy['global'],
          java = rainbow_delimiters.strategy['global'],
          javascript = rainbow_delimiters.strategy['global'],
          typescript = rainbow_delimiters.strategy['global'],
          php = rainbow_delimiters.strategy['global'],
          ruby = rainbow_delimiters.strategy['global'],
          scala = rainbow_delimiters.strategy['global'],
          c = rainbow_delimiters.strategy['global'],
          toml = rainbow_delimiters.strategy['global'],
          yaml = rainbow_delimiters.strategy['global'],
          json = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          javascript = 'rainbow-delimiters',
          typescript = 'rainbow-delimiters',
          tsx = 'rainbow-delimiters',
          html = 'rainbow-tags',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  end
}